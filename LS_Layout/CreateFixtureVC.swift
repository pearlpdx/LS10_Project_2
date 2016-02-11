//
//  CreateFixtureVC.swift
//  LS_2016
//
//  Created by Home on 1/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import CoreData

class CreateFixtureVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fixtureName: UITextField!
    
    var fixtures = [Channel]()
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        fixtureName.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func createChannel(sender: AnyObject!) {
        
        let app = UIApplication.sharedApplication().delegate as!  AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entityForName("Channel", inManagedObjectContext: context)!
        let channel = Channel(entity: entity, insertIntoManagedObjectContext: context)
        channel.name = fixtureName.text
        //channel.number = fixtures.count + 1
        context.insertObject(channel)
        
        do {
            try context.save()
        } catch {
            print("Could not save")
 
        }
        
            self.dismissViewControllerAnimated(true, completion: nil)
           
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
   
}
