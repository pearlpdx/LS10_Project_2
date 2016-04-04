//
//  CreateFixtureVC.swift
//  LS_2016
//
//  Created by Home on 1/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import CoreData

//class CreateFixtureVC: UIViewController, UITextFieldDelegate {
//    
//    @IBOutlet weak var fixtureName: UITextField!
//    
//   // var fixtures = [Channel]()
//   
//    @IBOutlet weak var FixtureNam: UITextField!
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        fixtureName.delegate = self;
//        
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    @IBAction func createChannel(sender: AnyObject!) {
//        
//      
//        let app = UIApplication.sharedApplication().delegate as!  AppDelegate
//        let context = app.managedObjectContext
//        let entity = NSEntityDescription.entityForName("Channel", inManagedObjectContext: context)!
//        let channel = Channel(entity: entity, insertIntoManagedObjectContext: context)
//        channel.name = fixtureName.text
//        //channel.number = fixtures.count + 1
//        channel.dmx16bit = dmxSwitchState
//       // channel.style = styles[pickedRow]
//        context.insertObject(channel)
//        fixtures.append(channel)
//        
//        do {
//            try context.save()
//        } catch {
//            print("Could not save")
// 
//        }
//        
//            self.dismissViewControllerAnimated(true, completion: nil)
//           
//    }
//    
//    @IBAction func cancelPressed(sender: AnyObject) {
//        
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    @IBAction func fixtureTypePress(sender: AnyObject) {
//        
//    }
//    
//    
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
//    
//    
//    //Picker view 
//    
//    
//    
//    
//    var styles = ["Intensity", "RGB", "RGBA", "RGBW", "RGBAW", "I+RGB", "I+RGBA", "I+RGBW", "I+RGBAW"]
//    
//    var dmxSwitchState = false
//    
//    
//    @IBAction func bitSwitchValueChanged(sender: UISwitch) {
//        dmxSwitchState = sender.on
//    }
//   
//}
