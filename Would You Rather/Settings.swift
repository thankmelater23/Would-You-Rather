//
//  Settings.swift
//  Would You Rather
//
//  Created by Andre on 2/11/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

// MARK: - Settings

class Settings {
    // MARK: - Variable

    // MARK: - Setup

    /// Makes class singleton
    private init() {}

    /// Gets and sets Userdefaults if ads was "In-App" purchased.
    class var adPurchased: Bool {
        get {
            log.info("Get Ad Purchased: \(self)")
            return settingsLink(to: SettingsKeys.adPurchased) as? Bool ?? false
        } set {
            set(key: SettingsKeys.adPurchased, value: newValue as AnyObject)
            log.info("Set Ad Purchased to: \(newValue)")
        }
    }

    /// Gets and sets Userdefaults if apps first time starting
    class var firstStart: Bool {
        get {
            log.info("Get First Start Purchased: \(self)")
            return settingsLink(to: SettingsKeys.firstStart) as? Bool ?? true
        } set {
            set(key: SettingsKeys.firstStart, value: newValue as AnyObject)
            log.info("Set First Start to: \(newValue)")
        }
    }

    /// Gets and sets Userdefaults of last Date Active.
    class var lastDateActive: Date {
        get {
            log.info("Get lastDateActive: \(self)")
            return settingsLink(to: SettingsKeys.lastDateActive) as? Date ?? Date()
        } set {
            set(key: SettingsKeys.lastDateActive, value: newValue as AnyObject)
            log.info("Set lastDateActive to: \(newValue)")
        }
    }

    /// Gets and sets Userdefaults of notifications Enabled.
    class var notificationsEnabled: Bool {
        get {
            log.info("Get notificationsEnabled: \(self)")
            return settingsLink(to: SettingsKeys.notificationsEnabled) as? Bool ?? false
        } set {
            set(key: SettingsKeys.notificationsEnabled, value: newValue as AnyObject)
            log.info("Set notificationsEnabled to: \(newValue)")
        }
    }

    /// Gets and sets Userdefaults of daysSinceNotActive Enabled.
    class var daysSinceNotActive: (days: [Int], activeDay: Date) {
        get {
            log.info("Get daysSinceNotActive: \(self)")
            return (settingsLink(to: SettingsKeys.daysSinceNotActive) as? (days: [Int], activeDay: Date))!
        } set {
            set(key: SettingsKeys.daysSinceNotActive, value: newValue as AnyObject)
            log.info("Set daysSinceNotActive to: \(newValue)")
        }
    }

    /// Gets and sets Userdefaults if apps first time starting
    class var onBoardComplete: Bool {
        get {
            log.info("On Board Complete : \(self)")
            return settingsLink(to: SettingsKeys.onBoardComplete) as? Bool ?? false
        } set {
            set(key: SettingsKeys.onBoardComplete, value: newValue as AnyObject)
            log.info("On Board Complete: \(newValue)")
        }
    }

    // MARK: - Utility Functions

    /// Returns Settings object value for key from user defaults
    ///
    /// - Parameter string: String key of settings value to retrieve
    /// - Returns: Returns value of given key from user defaults
    private class func settingsLink(to string: String) -> AnyObject? {
        log.verbose(#function)

        //        let path = getStringPath()
        //
        //        let dic = NSMutableDictionary(contentsOfFile: path)
        //        let value = dic?[string] as AnyObject
        //
        //        log.info("Got value for Settings Class: \(value)")
        //        return value

        let setting = UserDefaults.standard.value(forKey: string) as AnyObject?

        return setting
    }

    /**
     Sets value of given string
     - Parameter key: String for key setting value to set
     - Parameter value: Anyobject value for key setting rewrite
     */
    private class func set(key: String, value: AnyObject) {
        log.verbose(#function)

        //        let path = getStringPath()
        //
        //        let dic = NSMutableDictionary(contentsOfFile: path)
        //
        //        dic?.setValue(value, forKey: key)
        //
        //      log.info("Current Settings: \(dic)")
        //
        //        if let isWritten = dic?.write(toFile: path, atomically: true) {
        //            log.info("file saved: \(isWritten)")
        //        }else{log.warning("Settings Plist not saving")}
        //

        UserDefaults.standard.set(value, forKey: key)
    }

    /// Prints content of Settings file
    class func printFile() {
        log.verbose(#function)
        let fileManager = FileManager.default

        let path = getStringPath()

        if fileManager.fileExists(atPath: path) {
            if let dic = NSMutableDictionary(contentsOfFile: path) {
                log.info(dic)
            } else {
                log.warning("No data at path: \(path)")
            }
        }
    }

    /// Initializes Settings plist and initializes all values
    class func createInitialSettingsPlist() {
        defer {
            log.verbose(#function)
        }
        log.verbose(#function)
        log.info("Creating settings plist file")
        let fileManager = FileManager.default

        let path = getStringPath()

        if !fileManager.fileExists(atPath: path) {
            let data: [String: AnyObject] = [
                "adPurchased": false as AnyObject,
                "firstStart": false as AnyObject,
                "notificationsEnabled": false as AnyObject,
                "lastDateActive": Date() as AnyObject,
                "daysSinceNotActive": [(days: [Int], activeDay: Date).self] as AnyObject,
                "onBoardComplete": false as AnyObject,
            ]

            let someData = NSDictionary(dictionary: data)
            let isWritten = someData.write(toFile: path, atomically: true)
            log.info("is the file created: \(isWritten)")

            log.info(someData)

        } else {
            log.info("file exists")
        }
    }

    /// Returns: String of created path to Settings Plist
    class func getStringPath() -> String {
        log.verbose(#function)
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/Settings.plist")

        //    let path:String? = Bundle.main.path(forResource: "Settings", ofType: "plist")!

        log.info("File path: \(path) ")

        return path
    }
}
