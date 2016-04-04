//
//  SubVC.swift
//  LS10_Project
//
//  Created by Home on 3/16/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import CoreData

class SubVC: UIViewController,
                UITableViewDataSource,
            UITableViewDelegate  {
    
    
  
    
    @IBOutlet weak var subTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        subTableView.delegate = self
        subTableView.dataSource = self

        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        subTableView.editing = false
        setEditMode()
        subTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("SubTableViewCell", forIndexPath: indexPath) as? SubTableViewCell {
            
            let sub: SubMaster!
            sub = subMasters[indexPath.row]
            
            cell.configureCell(sub)
            return cell
        }else {
            return SubTableViewCell()
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subMasters.count
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if subTableView.editing == true {
            //Todo: add code to update sub
       print("selected: \(indexPath)")
        }
    }
    
    

    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            subMasters.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
            //Remove from CoreData
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "SubMaster")
            
            do {
                let results = try context.executeFetchRequest(fetchRequest)
                let sub = results[indexPath.row] as! NSManagedObject
                context.deleteObject(sub)
                
                do {
                    try context.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //disable slide to delete
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (subTableView.editing)
        {
            return UITableViewCellEditingStyle.Delete;
        }
        
        return UITableViewCellEditingStyle.None;
    }

    @IBAction func recordButtonPressed(sender: AnyObject) {
        
        // Standard UIActionSheet code here..
        let alertController = UIAlertController(title: "Record SubMaster", message: "The current lighting look will be saved in:", preferredStyle: .ActionSheet)
        
        let replace = UIAlertAction(title: "An Existing SubMaster", style: .Default, handler: { (action) -> Void in
            print("Select Sub Button Pressed")
        })
        
        let add = UIAlertAction(title: "A New SubMaster", style: .Default, handler: { (action) -> Void in
            print("Add Button Pressed")
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
        })
        
        alertController.addAction(replace)
        alertController.addAction(add)
        alertController.addAction(cancel)
        
        //to work on iPad where it does not know where to be be (and still on iPhone -
        //return nil if iPhone
        
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            // popoverPresentationController.sourceRect = sender.bounds
            //specifly location
            popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        }
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func editButtonPressed(sender: AnyObject) {
       subTableView.editing = !subTableView.editing
        setEditMode()
        
    }
    
    func setEditMode() {
        if subTableView.editing == true {
            addButton.hidden = false
            editButton.setTitle("DONE", forState: UIControlState.Normal)
        } else {
            addButton.hidden = true
            editButton.setTitle("EDIT", forState: UIControlState.Normal)
        }
       
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
