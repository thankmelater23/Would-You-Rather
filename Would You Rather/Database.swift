//
//  Database.swift
//  Would You Rather
//
//  Created by Andre on 5/25/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class Database {
    var duels: [Duel]? = [Duel]()

    //  init (){}

    func loadData() {
        // URL String
        let stringURL = "https://api.letsbuildthatapp.com/jsondecodable/course"

        // Creates URL from string URL
        guard let url = URL(string: stringURL) else { return }

        // URL Request used when going online
        //    var request = URLRequest(url: url)
        //
        //    //HTTP method type
        //    request.httpMethod = "POST"
        URLSession.shared.dataTask(with: url) { data, _, _ in

            // Validates data
            guard let data = data else { return }

            // Turns data to string
            let dataString = String(data: data, encoding: .utf8)

            print(dataString)

            // Serialize data into object
            do {
                self.duels = try JSONDecoder().decode([Duel].self, from: data)

                /// Swift 2/3
                //        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                //        print(json)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }

        }.resume()
    }

    func saveData(duel: Duel) {
        duels?.append(duel)

        func createLocalURL(path _: String) -> URL {
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                return url
            } else {
                fatalError("Could not retrieve documents directory")

                //      print(#function)
                //      guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError() }
                //
                //      let url = documentDirectoryUrl.appendingPathComponent(path)
                //
                //      return url
            }
        }

        // 1. Create a URL for documents-directory/posts.json
        let url = createLocalURL(path: File.WWYRHistory)
        // 2. Endcode our [Post] data to JSON Data
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(duels)
            // 3. Write this data to the url specified in step 1
            print(data)
            try data.write(to: url)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

public class Storage {
    fileprivate init() {}

    enum Directory {
        // Only documents and other data that is user-generated, or that cannot otherwise be recreated by your application, should be stored in the <Application_Home>/Documents directory and will be automatically backed up by iCloud.
        case documents

        // Data that can be downloaded again or regenerated should be stored in the <Application_Home>/Library/Caches directory. Examples of files you should put in the Caches directory include database cache files and downloadable content, such as that used by magazine, newspaper, and map applications.
        case caches
    }

    /// Returns URL constructed from specified directory
    fileprivate static func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory

        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }

        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }

    /// Store an encodable struct to the specified directory on disk
    ///
    /// - Parameters:
    ///   - object: the encodable struct to store
    ///   - directory: where to store the struct
    ///   - fileName: what to name the file where the struct data will be stored
    static func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)

        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    /// Retrieve and convert a struct from a file on disk
    ///
    /// - Parameters:
    ///   - fileName: name of the file where struct data is stored
    ///   - directory: directory where struct data is stored
    ///   - type: struct type (i.e. Message.self)
    /// - Returns: decoded struct model(s) of data
    static func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)

        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File at path \(url.path) does not exist!")
        }

        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(url.path)!")
        }
    }

    /// Remove all files at specified directory
    static func clear(_ directory: Directory) {
        let url = getURL(for: directory)
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try FileManager.default.removeItem(at: fileUrl)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    /// Remove specified file from specified directory
    static func remove(_ fileName: String, from directory: Directory) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    /// Returns BOOL indicating whether file exists at specified directory with specified file name
    static func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
}
