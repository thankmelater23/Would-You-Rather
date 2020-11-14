//
//  HistoryTableViewController.swift
//  Would You Rather
//
//  Created by Andre on 5/22/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import GoogleMobileAds
import UIKit

class HistoryTableViewController: UITableViewController {
    var bannerView: GADBannerView!
    var duels = [Duel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        adBannerInit()

        if Storage.fileExists(File.WWYRHistory, in: .documents) {
            duels = Storage.retrieve(File.WWYRHistory, from: .documents, as: [Duel].self)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //     self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func loadData() -> [Duel]? {
        if let url = Bundle.main.url(forResource: "History", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Duel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return duels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell: HistoryTableViewCell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier.historyCell) as? HistoryTableViewCell)!

        cell.setCell(duels[index], index: index)

        if index % 2 == 0 {
            cell.backgroundColor = UIColor.black
        } else {
            cell.backgroundColor = UIColor.white
        }

        return cell
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    guard let vc = segue.destination as? UIViewController else { return }
    //
    //    switch segue.identifier {
    //    case Segue.Main_To_History:
    //      log.verbose("Segue")
    //      (vc as! BoledoHistoryTableViewController).boledos = (sender as! [Boledo]?)!
    //    case Segue.BoledoMain_To_BoledoGenerator?:
    //      log.verbose("Segue")
    //    case Segue.Unwind_To_MainMenu?:
    //      log.verbose("Segue")
    //    default:
    //      log.verbose("Segue")
    //
    //   }
}
