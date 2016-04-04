//
//  CoreData.swift
//  LS10_Project
//
//  Created by Home on 2/11/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import Foundation
import UIKit
import CoreData


var fixtures = [Channel]()
var subMasters = [SubMaster]()
var groups = [Group]()

class CoreDataHandler: NSObject {
    
    func fetchAndSetResults() {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Channel")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            fixtures = results as! [Channel]
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    func subFetchAndSetResults() {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "SubMaster")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            subMasters = results as! [SubMaster]
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    
    
    func groupFetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Group")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            groups = results as! [Group]
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
  }


