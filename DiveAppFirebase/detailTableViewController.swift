//
//  detailTableViewController.swift
//  DiveAppFirebase
//
//  Created by Trym Lintzen on 24-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import UIKit
import Kingfisher

class detailTableViewController: UITableViewController {

 var selectedDiveAppItemDetail: DiveAppProperties?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let divingNib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        self.tableView.register(divingNib, forCellReuseIdentifier: TableCellIDs.detailTableViewCellID)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let cell = tableView.cellForRow(at: IndexPath.init(row: 0 , section: 0)) as! DetailTableViewCell
        
        selectedDiveAppItemDetail?.name = (cell.nameLabel?.text)!
        selectedDiveAppItemDetail?.ocean = cell.oceanLabel.text!
        selectedDiveAppItemDetail?.id = cell.idLabel.text!
        if let depth = Int(cell.depthMetresLabel.text!) {
            selectedDiveAppItemDetail?.depthMetres = depth
            DiveAppService.sharedInstance.changeDiveItem(diveItem: selectedDiveAppItemDetail!)
        }
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
        return 1
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIDs.detailTableViewCellID, for: indexPath) as! DetailTableViewCell
        
        cell.nameLabel?.text = selectedDiveAppItemDetail?.name
        cell.oceanLabel?.text = selectedDiveAppItemDetail?.ocean
        cell.idLabel?.text = selectedDiveAppItemDetail?.id
        if let depthMetres = selectedDiveAppItemDetail?.depthMetres {
            cell.depthMetresLabel.text = "\(depthMetres)"
        }
        let url = URL(string: (selectedDiveAppItemDetail?.imageURLS[0])!)
        cell.imageField.kf.setImage(with: url)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
