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

var _diplayLast = false
 var inGroupMode = false


class ViewController: UIViewController,
                    UITableViewDataSource,
                    UITableViewDelegate,
                    UISearchBarDelegate {
    
    @IBOutlet weak var chanTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var indOffButton: UIButton!
    @IBOutlet weak var groupButton: UIButton!
    
    var filteredFixtures = [Channel]()
    var grpSel = [GroupSection]()
    var inSearchMode = false
//    var inGroupMode = false
    
    var displayLast: Bool {
        get {
           return _diplayLast
        }
        set {
            _diplayLast = newValue
        }
    }
    
    let sACN = ACNsend()
    let myCoreData = CoreDataHandler()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chanTableView.delegate = self
        chanTableView.dataSource = self
        chanTableView.remembersLastFocusedIndexPath = true

        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Search
        
        //load user data
        myCoreData.fetchAndSetResults()
        //dismiss keyboard
        self.hideKeyboardWhenTappedAround()
    
//*******TEMP***********  setup datagram and start sACN refresh
        for _ in 0...511 {
            dmx.append(UInt8(0))
        }
        
        //Start sACN and fade update(later) (move to background)
        sACN.startTimer(dmx, universe: 1)

    }


    override func viewDidAppear(animated: Bool) {
        if inGroupMode {
            setGroupMode()
            editButton.hidden = true
            groupButton.setImage(UIImage(named: "Sections"), forState: UIControlState.Normal)
            
        }
        chanTableView.reloadData()
        
        if displayLast == true {
            displayLast = false
            // Stay in Edit Mode
            chanTableView.editing = true
            isEditMode()
            scrollToLastRow()
        }
        checkIndOff()
    }
    
    

    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    //


//Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("FixtureCell", forIndexPath: indexPath) as? TableFixtureCell {
            
            let fixture: Channel!
            
            if inGroupMode {
                fixture = grpSel[indexPath.section].fixtures[indexPath.row]
            }else {
                
                if inSearchMode {
                    fixture = filteredFixtures[indexPath.row]
                } else{
                    fixture = fixtures[indexPath.row]
                }
            }
            cell.configureCell(fixture)
            cell.tableVC = self
            return cell
            
        }else {
            return TableFixtureCell()
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if inGroupMode {
            return grpSel.count
        }else {
        return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inGroupMode {
            return grpSel[section].fixtures.count
        }else {
        
        if inSearchMode {
            return filteredFixtures.count
        } else {
           return fixtures.count
        }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if inGroupMode {
            return 35
        }else {
            return 1
        }
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if inGroupMode {
//        return grpSel[section].group
//        }else {
//            return ""
//        }
//    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
       
        let headerView = tableView.dequeueReusableCellWithIdentifier("FixtureHeaderTVCell")  as! FixtureHeaderTVCell
         if inGroupMode {
        headerView.fixHeaderLbl.text = grpSel[section].group
            return headerView
         } else {
            return nil
        }
        
    }
    
    func scrollToLastRow() {
        let indexPath = NSIndexPath(forRow: fixtures.count - 1, inSection: 0)
        chanTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
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

    
    
//Search Bar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            if inGroupMode  {
                setGroupMode()
            }
            chanTableView.reloadData()
            
        } else {
            inSearchMode = true
            
            
            let lower = searchBar.text!.lowercaseString
            filteredFixtures = fixtures.filter({$0.name?.lowercaseString.rangeOfString(lower) != nil
                || $0.number?.lowercaseString.rangeOfString(lower) != nil})
            
            if inGroupMode {
                setGroupMode()
            }
            chanTableView.reloadData()
        }
        
    }
    
//Functions
    func isEditMode() {
        if chanTableView.editing == true {
            editButton.setTitle("DONE", forState: UIControlState.Normal)
            addButton.hidden = false
            indOffButton.hidden = true
            groupButton.hidden = true
        } else {
            editButton.setTitle("EDIT", forState: UIControlState.Normal)
            addButton.hidden = true
            indOffButton.hidden = false
            groupButton.hidden = false
        }
    }
    
    func checkIndOff() {
        var inInd = true
       
        for fx in fixtures {
            if fx.independent == true {
             inInd = false
            }
        }
        indOffButton.hidden = inInd
    }
    
    func setGroupMode() {
        var groupFixtures = [Channel]()
        var useFixtures = fixtures
        grpSel = [GroupSection]()
        if inSearchMode == true {
            useFixtures = filteredFixtures
        }
        
        for grp in categories {
            groupFixtures = useFixtures.filter({$0.group == grp})
            if groupFixtures.count != 0 {
                let groupSel = GroupSection(group: grp, fixtures: groupFixtures)
                grpSel.append(groupSel)
            }
        }
        groupFixtures = useFixtures.filter({$0.group == "" || $0.group == nil})
        if groupFixtures.count != 0 {
            let groupSel = GroupSection(group: "Not in Group", fixtures: groupFixtures)
            grpSel.append(groupSel)
        }
 
        
        
    }
    
   
  //Actions
    
    @IBAction func colorButtonPress(sender: AnyObject) {
        
    }

   //indOffButtonPressed
    @IBAction func unlockButPressed(sender: AnyObject) {
        
        for fx in fixtures {
            fx.independent = false
        }
        indOffButton.hidden = true
        chanTableView.reloadData()
    }

    
    @IBAction func eidtButtonPessed(sender: AnyObject) {
        
        chanTableView.editing = !chanTableView.editing
        isEditMode()
           }
    
    @IBAction func groupButPressed(sender: AnyObject) {
        inGroupMode = !inGroupMode
        
        if inGroupMode == true {
            editButton.hidden = true
            groupButton.setImage(UIImage(named: "Sections"), forState: UIControlState.Normal)
            setGroupMode()
            chanTableView.reloadData()
          
        } else {
            editButton.hidden = false
             groupButton.setImage(UIImage(named: "noSections"), forState: UIControlState.Normal)
             chanTableView.reloadData()
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

class GroupSection {
    
    var group: String!
    var fixtures: [Channel]!
    
    init (group: String, fixtures: [Channel] ) {
        
        self.group = group
        self.fixtures = fixtures
    }
    
}


