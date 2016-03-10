//
//  CreateFixtureTableViewController.swift
//  LS10_Project
//
//  Created by Gordon Pearlman on 3/7/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import CoreData

var _fixtureStyle = "Intensity"
var _fixtureCategory = ""


class CreateFixtureTableViewController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var fixtureName: UITextField!
    @IBOutlet weak var styleLbl: UILabel!
    @IBOutlet weak var catLbl: UILabel!
    
    @IBOutlet weak var tempFixtureName: UITextField!
    
    var fixtureStyle: String {
        get{
            return  _fixtureStyle
        }
        set {
          _fixtureStyle = newValue
        }
    }
    
    var fixtureCategory: String {
        get{
            return  _fixtureCategory
        }
        set {
            _fixtureCategory = newValue
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         fixtureName.delegate = self;

//         Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        styleLbl.text = "\(fixtureStyle)"
        catLbl.text = "\(fixtureCategory)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

       
    @IBAction func createChannel(sender: AnyObject!) {
        
        
        let app = UIApplication.sharedApplication().delegate as!  AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entityForName("Channel", inManagedObjectContext: context)!
        let channel = Channel(entity: entity, insertIntoManagedObjectContext: context)
        channel.name = fixtureName.text
        //channel.number = fixtures.count + 1
        channel.dmx16bit = dmxSwitchState
        channel.style = fixtureStyle
        channel.indRed = 1.0
        channel.indGreen = 1.0
        channel.indBlue = 1.0
        channel.indLevel = 1.0
        channel.indAmber = 0.0
        channel.indWhite = 0.0
        
        context.insertObject(channel)
        fixtures.append(channel)
        
        do {
            try context.save()
        } catch {
            print("Could not save")
            
        }
        
       // self.dismissViewControllerAnimated(true, completion: nil)
        
    }
 
    
    
    var dmxSwitchState = false
    
    @IBAction func fixtureTypePressed(sender: AnyObject) {
    }
    
    @IBAction func dmxPatchPressed(sender: AnyObject) {
    }
    
    @IBAction func fixtureCategoryPressed(sender: AnyObject) {
    }
    
    
    @IBAction func bitSwitchValueChanged(sender: UISwitch) {
        dmxSwitchState = sender.on
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if let sourceController = segue.sourceViewController as? FixtureTypeTableViewController {
//            
//            self.fixtureStyle = sourceController.selStyle
//        }
    
    
    
    
    
}
