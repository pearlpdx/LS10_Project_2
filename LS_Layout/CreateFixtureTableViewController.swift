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
var fixtureNameString = ""


class CreateFixtureTableViewController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var fixtureName: UITextField!
    @IBOutlet weak var styleLbl: UILabel!
    @IBOutlet weak var catLbl: UILabel!
    @IBOutlet weak var numOfFixture: UILabel!
    @IBOutlet weak var numOfFixStepper: UIStepper!
    
    var dmxSwitchState = false
    
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
        
        styleLbl.text = "\(fixtureStyle)"
        catLbl.text = "\(fixtureCategory)"
        fixtureName.text = fixtureNameString
        

//         Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source       
    @IBAction func createChannel(sender: AnyObject!) {
        
        
        let numOfFix = Int(numOfFixture.text!)
        
        for _ in (0...numOfFix! - 1) {
     
            let app = UIApplication.sharedApplication().delegate as!  AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Channel", inManagedObjectContext: context)!
            let channel = Channel(entity: entity, insertIntoManagedObjectContext: context)
            channel.name = fixtureName.text
            channel.dmx16bit = dmxSwitchState
            channel.style = fixtureStyle
            channel.group = fixtureCategory
            channel.indRed = 1.0
            channel.indGreen = 1.0
            channel.indBlue = 1.0
            channel.indLevel = 0.0
            channel.indAmber = 0.0
            channel.indWhite = 0.0
            
            let ii = findNextFixtureNumber()
            channel.number = "\(ii)"
            
            context.insertObject(channel)
            fixtures.append(channel)
            
            fixtureNameString = ""
            
            do {
                try context.save()
            } catch {
                print("Could not save")
            }
        }
    }
    
    
    func findNextFixtureNumber() -> Int {
        if fixtures.count == 0 {
            return 1
        } else {
            var i = 0
            for fix in fixtures {
                if Int(fix.number!) > i {
                    i = Int(fix.number!)!
                }
            }
            return i + 1
        }
    }
    
 
    @IBAction func fixtureSetupEndEdit(sender: AnyObject) {
        fixtureNameString = fixtureName.text!
    }
    
    @IBAction func numOfFixtureStepper(sender: AnyObject) {
        numOfFixture.text = "\(Int(numOfFixStepper.value))"
    }
    
    // MARK: - Navigation
    
    //Seque
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (sender as? UIButton) != nil {            
            if let tabVC = segue.destinationViewController as? UITabBarController {
                if let destVC = tabVC.viewControllers?.first as? ViewController {
                    destVC.displayLast = true
                }
            }
        }
        
    }
    
    
    
//    @IBAction func fixtureTypePressed(sender: AnyObject) {
//    }
//    
//    @IBAction func dmxPatchPressed(sender: AnyObject) {
//    }
//    
//    @IBAction func fixtureCategoryPressed(sender: AnyObject) {
//    }
    
//    @IBAction func bitSwitchValueChanged(sender: UISwitch) {
//        dmxSwitchState = sender.on
//    }
//    
    
    
    
    
}
