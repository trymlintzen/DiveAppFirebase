//
//  TableViewController.swift
//  DiveAppFirebase
//
//  Created by Trym Lintzen on 24-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var diveAppObjects: [DiveAppProperties] = []
    var selectedDiveAppItem: DiveAppProperties?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MainTableViewController.notifyObservers(notification:)),
                                               name: NSNotification.Name(rawValue: notificationIDs.allItemsID),
                                               object: nil)
        
        DiveAppService.sharedInstance.getDiveAppData()
        let divingNib = UINib(nibName: "ShortTableViewCell", bundle: nil)
        self.tableView.register(divingNib, forCellReuseIdentifier: TableCellIDs.shortTableViewCellID)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @objc func notifyObservers(notification: NSNotification) {
        var diveItemDict = notification.userInfo as! Dictionary<String , [DiveAppProperties]>
        diveAppObjects = diveItemDict[dictKey.divingAppData]!
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diveAppObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIDs.shortTableViewCellID , for: indexPath) as! ShortTableViewCell
        
        let storeObject = diveAppObjects[indexPath.row]
        cell.nameMain?.text = storeObject.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDiveAppItem = diveAppObjects[indexPath.row]
        performSegue(withIdentifier: seguesIdentifiers.detailTableSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seguesIdentifiers.detailTableSegue {
            
            // Hier zeg je dus: Ga naar "detail(View/Table)Segue" als op een selectedShoppingItem wordt geklikt, want check regel 82
            let detailView = segue.destination as! detailTableViewController
            detailView.selectedDiveAppItemDetail = self.selectedDiveAppItem
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
