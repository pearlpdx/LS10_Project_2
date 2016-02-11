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

class ViewController: UIViewController,
                    UITableViewDataSource,
                    UITableViewDelegate,
                    UISearchBarDelegate {
    
    @IBOutlet weak var chanTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
 
    
    var fixtures = [Channel]()
    var filteredFixtures = [Channel]()
    
    var inSearchMode = false
    
    
    
    
    let sACN = ACNsend()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chanTableView.delegate = self
        chanTableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Search
        
      
        
        for var x = 0; x < 512; x++ {
            dmx.append(UInt8(0))
        }
        
        sACN.startTimer(dmx, universe: 1)

    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//

    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        chanTableView.reloadData()
    }

    
    
    func fetchAndSetResults() {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Channel")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.fixtures = results as! [Channel]
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    //Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
//        if let cell = tableView.dequeueReusableCellWithIdentifier("FixtureCell") as? TableFixtureCell {
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

    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let colorPickerVC = segue.destinationViewController as? ColorPickerVC {
            
           // if  let TableFixtureCell = sender as? TableFixtureCell{
            
            if let colorButton = sender as? UIButton {
                
                let fixtureCell = colorButton.superview?.superview as! TableFixtureCell
          
                colorPickerVC.curChannel = fixtureCell.fixture
            }
        }
    }


    
    @IBAction func unlockButPressed(sender: AnyObject) {
        
        for fx in fixtures {
            fx.independent = false
        }
        chanTableView.reloadData()
    }

    
    

    
    
}

