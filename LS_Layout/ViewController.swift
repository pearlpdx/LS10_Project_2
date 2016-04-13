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


var _diplayLast = false
 var inGroupMode = false


class ViewController: UIViewController,
                    UITableViewDataSource,
                    UITableViewDelegate,
                    UISearchBarDelegate {

    @IBOutlet weak var fixTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var indOffButton: UIButton!
    @IBOutlet weak var groupButton: UIButton!
    
    var filteredFixtures = [Fixture]()
    var grpSel = [GroupSection]()
    var inSearchMode = false
    
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
        
          NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshTable(_:)), name: "refresh", object: nil)
        
        fixTableView.delegate = self
        fixTableView.dataSource = self
        fixTableView.remembersLastFocusedIndexPath = true

        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Search
        
        
        //load user data
// xxxx       myCoreData.fetchAndSetResults()
//        myCoreData.subFetchAndSetResults()
//        myCoreData.groupFetchAndSetResults()
        
        //dismiss keyboard
       // self.hideKeyboardWhenTappedAround()
    
//*******TEMP***********  setup datagram and start sACN refresh
        for _ in 0...511 {
            dmx.append(UInt8(0))
        }
        
        //Start sACN and fade update(later) (move to background)
        sACN.startTimer(dmx, universe: 1)

    }

    func refreshTable(notification: NSNotification) {
        fixTableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        if inGroupMode {
            setGroupMode()
            editButton.hidden = true
            groupButton.setImage(UIImage(named: "Sections"), forState: UIControlState.Normal)
            
        }
        fixTableView.reloadData()
        
        if displayLast == true {
            displayLast = false
            // Stay in Edit Mode
            fixTableView.editing = true
            isEditMode()
            scrollToLastRow()
        }
        checkIndOff()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    //

    
//Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("FixtureCell", forIndexPath: indexPath) as? TableFixtureCell {
            
            let fixture: Fixture!
            
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
            //allow callback to VC
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
        fixTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
    }
   
    //disable slide to delete
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (fixTableView.editing)
        {
            return UITableViewCellEditingStyle.Delete;
        }
        
        return UITableViewCellEditingStyle.None;
    }
    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            fixtures.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
            //Remove from CoreData
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Channel")
            
            do {
                let results = try context.executeFetchRequest(fetchRequest)
                let fix = results[indexPath.row] as! NSManagedObject
                context.deleteObject(fix)
                
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
   
    // Override to support rearranging the table view.
//    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//        let fx = fixtures[fromIndexPath.row]
//        fixtures.removeAtIndex(fromIndexPath.row)
//        fixtures.insert(fx, atIndex: toIndexPath.row)
//    }
//
    
    
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
            fixTableView.reloadData()
            
        } else {
            inSearchMode = true
            
            
            let lower = searchBar.text!.lowercaseString
            filteredFixtures = fixtures.filter({$0.name?.lowercaseString.rangeOfString(lower) != nil
                || $0.number?.lowercaseString.rangeOfString(lower) != nil})
            
            if inGroupMode {
                setGroupMode()
            }
            fixTableView.reloadData()
        }
        
    }
    
//Functions
    func isEditMode() {
        if fixTableView.editing == true {
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
        var groupFixtures = [Fixture]()
        var useFixtures = fixtures
        grpSel = [GroupSection]()
        if inSearchMode == true {
            useFixtures = filteredFixtures
        }
        
        for grp in groups {
            groupFixtures = useFixtures.filter({$0.group == grp.name})
            if groupFixtures.count != 0 {
                let groupSel = GroupSection(group: grp.name!, fixtures: groupFixtures)
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
        fixTableView.reloadData()
    }

    
    @IBAction func eidtButtonPessed(sender: AnyObject) {
        
        fixTableView.editing = !fixTableView.editing
        isEditMode()
           }
    
    @IBAction func groupButPressed(sender: AnyObject) {
        inGroupMode = !inGroupMode
        
        if inGroupMode == true {
            editButton.hidden = true
            groupButton.setImage(UIImage(named: "Sections"), forState: UIControlState.Normal)
            setGroupMode()
            fixTableView.reloadData()
          
        } else {
            editButton.hidden = false
             groupButton.setImage(UIImage(named: "noSections"), forState: UIControlState.Normal)
             fixTableView.reloadData()
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
    var fixtures: [Fixture]!
    
    init (group: String, fixtures: [Fixture] ) {
        
        self.group = group
        self.fixtures = fixtures
    }
    
}


