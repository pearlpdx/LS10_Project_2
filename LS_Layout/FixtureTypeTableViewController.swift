//
//  FixtureTypeTableViewController.swift
//  LS10_Project
//
//  Created by Gordon Pearlman on 3/7/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class FixtureTypeTableViewController: UITableViewController {
    
     var styles = ["Intensity", "RGB", "RGBA", "RGBW", "RGBAW", "I+RGB", "I+RGBA", "I+RGBW", "I+RGBAW"]
    
    var numOfChans = [1, 3, 4, 4, 5, 4, 5, 5, 6]
    var selStyle = ""
   
//    var selectedCell: UITableViewCell? {
//        willSet {
//        selectedCell?.accessoryType = .None
//        newValue?.accessoryType = .Checkmark
//    }
//}

    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationItem.title = "FIXTURE TYPE"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return styles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StyleCell", forIndexPath: indexPath)
        
       cell.textLabel?.text = styles[indexPath.row]
        cell.detailTextLabel?.text = "\(numOfChans[indexPath.row]) channels"

        return cell
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Choose the Fixture Style"
//    }
        
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        selStyle = (cell?.textLabel?.text)!
    }
    
//
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navVC = segue.destinationViewController as! UINavigationController
        let destVC = navVC.viewControllers.first as! CreateFixtureTableViewController  
        destVC.fixtureStyle = selStyle
    }

}
