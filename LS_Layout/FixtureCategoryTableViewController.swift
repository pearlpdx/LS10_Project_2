//
//  FixtureCategoryTableViewController.swift
//  LS10_Project
//
//  Created by Gordon Pearlman on 3/8/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

//var categories = ["First Beam", "Second Beam", "First Electric", "Second Electric", "Cyc"]

class FixtureCategoryTableViewController: UITableViewController {
   
        var selCategory = ""
    
    @IBOutlet weak var insertTextBox: UITextField!
    
    @IBOutlet weak var insertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.editing = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = "FIXTURE GROUP"
     
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
        return categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        // Configure the cell...

        return cell
    }
  
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
    let cell = self.tableView.cellForRowAtIndexPath(indexPath)
    selCategory = (cell?.textLabel?.text)!
    }

    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        if editing {
              tableView.setEditing((editing), animated: true)
            insertView.hidden = false
        }else {
              tableView.setEditing((editing), animated: false)
            insertView.hidden = true
        }
        
      
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            categories.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let st = categories[fromIndexPath.row]
        categories.removeAtIndex(fromIndexPath.row)
        categories.insert(st, atIndex: toIndexPath.row)

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

//    @IBAction func editButtonPressed(sender: AnyObject) {
//        
//        tableView.editing = !tableView.editing
//        insertView.hidden = !tableView.editing
////        if tableView.editing == true {
////            editButton.setTitle("DONE", forState: UIControlState.Normal)
////           
////        } else {
////            editButton.setTitle("EDIT", forState: UIControlState.Normal)
////        }
//    }
//    
    
    @IBAction func insertButtonPress(sender: AnyObject) {
        
        if insertTextBox.text != "" || insertTextBox.text != nil {
            categories.append(insertTextBox.text!)
            tableView.reloadData()
        }
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navVC = segue.destinationViewController as! UINavigationController
        let destVC = navVC.viewControllers.first as! CreateFixtureTableViewController
        destVC.fixtureCategory = selCategory
    }

}
