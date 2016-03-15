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

        return cell
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Choose the Fixture Style"
//    }
        
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        selStyle = (cell?.textLabel?.text)!
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
//        selStyle = (cell?.textLabel?.text)!
//        
//        var controller: CreateFixtureTableViewController
//        controller = self.storyboard?.instantiateViewControllerWithIdentifier("CreateFixtureTableViewController") as! CreateFixtureTableViewController
//        controller.fixtureStyle = (cell?.textLabel?.text)!
//        
//        self.presentViewController(controller, animated: true, completion: nil)
        
      // self.mapView.selectAnnotation(self.mapView.annotations(indexPath.row), animated: true)
  //  }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navVC = segue.destinationViewController as! UINavigationController
        let destVC = navVC.viewControllers.first as! CreateFixtureTableViewController  
        destVC.fixtureStyle = selStyle
    }

}
