//
//  ViewController.swift
//  LS_Layout
//
//  Created by Home on 2/1/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import  CoreData

var dmx: [UInt8] = []

//TODO Move to Core Data
var categories = ["First Beam", "Second Beam", "First Electric", "Second Electric", "Cyc"]


class ViewController: UIViewController,
                    UITableViewDataSource,
                    UITableViewDelegate,
                    UISearchBarDelegate {
    
    @IBOutlet weak var chanTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
 
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var indOffButton: UIButton!
    
//    var fixtures = [Channel]()
    var filteredFixtures = [Channel]()
    
    var inSearchMode = false
    
    
    
    
    let sACN = ACNsend()
    let myCoreData = CoreDataHandler()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chanTableView.delegate = self
        chanTableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Search
        
        //load user data
        myCoreData.fetchAndSetResults()
        
        //setup datagram and start sACN refresh
        for var x = 0; x < 512; x++ {
            dmx.append(UInt8(0))
        }
        
        //get UDID 
        
        let uDID = UIDevice.currentDevice().identifierForVendor
        
        print(uDID)
        
        let uDIDstring = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        print(uDIDstring)

        sACN.startTimer(dmx, universe: 1)

    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//

    override func viewDidAppear(animated: Bool) {
        chanTableView.reloadData()
    }


    //Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("FixtureCell", forIndexPath: indexPath) as? TableFixtureCell {
        
            let fixture: Channel!

            if inSearchMode {
                fixture = filteredFixtures[indexPath.row]
            } else{
                fixture = fixtures[indexPath.row]
            }
            
            cell.configureCell(fixture)
            return cell
        }else {
            return TableFixtureCell()
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredFixtures.count
        } else {
           return fixtures.count
        }
    }
    
    
    //Search Bar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            chanTableView.reloadData()
            
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredFixtures = fixtures.filter({$0.name?.rangeOfString(lower) != nil})
            chanTableView.reloadData()
        }
    }
    
    
    
    // Override to support editing the table view.
     func chanTableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            fixtures.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
         //TODO  Save to CoreData  ************************
    }

   
   
    // Override to support rearranging the table view.
      func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let fx = fixtures[fromIndexPath.row]
        fixtures.removeAtIndex(fromIndexPath.row)
        fixtures.insert(fx, atIndex: toIndexPath.row)
  //TODO  Save to CoreData  ************************
    }
    
   
  //Actions
    @IBAction func unlockButPressed(sender: AnyObject) {
        
        for fx in fixtures {
            fx.independent = false
        }
        chanTableView.reloadData()
    }

    
    @IBAction func eidtButtonPessed(sender: AnyObject) {
        
         chanTableView.editing = !chanTableView.editing
        if chanTableView.editing == true {
            editButton.setTitle("DONE", forState: UIControlState.Normal)
            addButton.hidden = false
            indOffButton.hidden = true
        } else {
            editButton.setTitle("EDIT", forState: UIControlState.Normal)
            addButton.hidden = true
            indOffButton.hidden = false
        }
    }
    
   //Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let colorPickerVC = segue.destinationViewController as? ColorPickerVC {
            
            // if  let TableFixtureCell = sender as? TableFixtureCell{
            
            if let colorButton = sender as? UIButton {
                
                let fixtureCell = colorButton.superview?.superview as! TableFixtureCell
                
                colorPickerVC.curFixture = fixtureCell.fixture
            }
        }
    }
    

    
    
}

