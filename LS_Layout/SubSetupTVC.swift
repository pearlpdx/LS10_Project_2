//
//  SubSetupTVC.swift
//  LS10_Project
//
//  Created by Home on 3/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import CoreData

var _curTime: Int32 = -1

class SubSetupTVC: UITableViewController {
    
    var curTime: Int32 {
        get{
            return  _curTime
        }
        set {
            _curTime = newValue
        }
    }
    
   
    
    
    @IBOutlet weak var fadeTimeDetail: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if curTime == -1 {
            curTime = 50
        }
        
        var st = ""
        if (curTime / 600) != 0 {
            st = "\(curTime / 600) min "
        }
        st += ("\((curTime % 600) / 10).\((curTime % 60) % 10) sec")
            fadeTimeDetail.text = st
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        let app = UIApplication.sharedApplication().delegate as!  AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entityForName("SubMaster", inManagedObjectContext: context)!
        let sub = SubMaster(entity: entity, insertIntoManagedObjectContext: context)
        
        sub.number = findNextSubNumber()
       
        sub.name = nameTextField.text
        
        sub.time = Int32(curTime)
        
        context.insertObject(sub)
        subMasters.append(sub)
        
        fixtureNameString = ""
        
        do {
            try context.save()
        } catch {
            print("Could not save")
        }

        
        
         dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func findNextSubNumber() -> Int16 {
        if subMasters.count == 0 {
            return 1
        } else {
            var i:Int16 = 0
            for sub in subMasters {
                if sub.number > i {
                    i = sub.number
                }
            }
            return i + 1
        }
    }

    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
         dismissViewControllerAnimated(true, completion: nil)
    }
    
   
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  let navVC = segue.destinationViewController as? UINavigationController {
            
            if let destVC = navVC.viewControllers.first as? TimePickerTVC {
                destVC.curTime = curTime
                
            }
        }
        
//        } else if (sender as? UIBarButtonItem) != nil {
//            if let tabVC = segue.destinationViewController as? UITabBarController {
//                if let destVC = tabVC.viewControllers?.first as? ViewController {
//                    destVC.displayLast = true
//                }
//            }
//            
//        }
        
        
    }
}

