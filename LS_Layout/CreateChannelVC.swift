//
//  CreateChannelVC.swift
//  LS_2016
//
//  Created by Home on 1/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import CoreData

class CreateChannelVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var channelName: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        channelName.delegate = self;
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
        channel.name = channelName.text
        context.insertObject(channel)
        
        do {
            try context.save()
        } catch {
            print("Could not save")
 
        }
        
            self.dismissViewControllerAnimated(false, completion: nil)
           
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
