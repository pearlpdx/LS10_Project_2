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
        
     //   hideKeyboardWhenTappedAround()
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
    
    @IBAction func saveFixturePressed(sender: AnyObject) {
        
        let numOfFix = Int(numOfFixture.text!)
        
        for _ in (0...numOfFix! - 1) {
     
            let app = UIApplication.sharedApplication().delegate as!  AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Fixture", inManagedObjectContext: context)!
            let fixture = Fixture(entity: entity, insertIntoManagedObjectContext: context)
            fixture.name = fixtureName.text
            fixture.dmx16bit = dmxSwitchState
            fixture.style = fixtureStyle
            fixture.group = fixtureCategory
            
            //TODO: REMOVE WHEN READY
          //  fixture.indRed = 1.0
//            fixture.indGreen = 1.0
//            fixture.indBlue = 1.0
            //fixture.indLevel = 0.0
//            fixture.indAmber = 0.0
//            fixture.indWhite = 0.0
            //_______________________
            
            fixture.setUpChannels()
            fixture.getChanByName("I")?.finalLevel = 0.0
            fixture.getChanByName("R")?.finalLevel = 1.0
            fixture.getChanByName("G")?.finalLevel = 1.0
            fixture.getChanByName("B")?.finalLevel = 1.0
            fixture.getChanByName("A")?.finalLevel = 0.0
            fixture.getChanByName("W")?.finalLevel = 0.0
            
            
            let ii = findNextFixtureNumber()
            fixture.number = "\(ii)"
            
            context.insertObject(fixture)
            fixtures.append(fixture)
            
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
