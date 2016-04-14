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


var fixtures = [Fixture]()
var subMasters = [SubMaster]()
var groups = [Group]()

class CoreDataHandler: NSObject {
    
    func fetchAndSetResults() {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Fixture")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            fixtures = results as! [Fixture]
        } catch let err as NSError {
            print(err.debugDescription)
        }
        for fix in fixtures {
            fix .setUpChannels()
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
    
    
    
    func fixFetchAndSetResults() {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "FixtureStore")
        let sortDescriptor1 = NSSortDescriptor(key: "subNumber", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "fixtureNumber", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
       
        var tempFix = [FixtureStore]()

            do {
                let results = try context.executeFetchRequest(fetchRequest)
                tempFix = results as! [FixtureStore]
                
                for fix in tempFix {                    
                  //  print("sub: \(fix.subNumber) fix: \(fix.fixtureNumber) ")
                    subMasters[Int(fix.subNumber - 1)].fixStores.append(fix)
                }
                
            } catch let err as NSError {
                print(err.debugDescription)
            }
        
    }
    
        
    
    func chanFetchAndSetResults() {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ChannelStore")
        let sortDescriptor1 = NSSortDescriptor(key: "subNumber", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "fixtureNumber", ascending: true)
        let sortDescriptor3 = NSSortDescriptor(key: "chanNumber", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2, sortDescriptor3]
        
        var tempChan = [ChannelStore]()
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            tempChan = results as! [ChannelStore]
            
            for chan in tempChan {
                // print ("lev: \(chan.level) icbf: \(chan.icbf!) name: \(chan.name!) sub: \(chan.subNumber) fix: \(chan.fixtureNumber) chan: \(chan.chanNumber)" )
                subMasters[Int(chan.subNumber - 1)].fixStores[Int(chan.fixtureNumber - 1)].channelStores.append(chan)
            }
            
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


