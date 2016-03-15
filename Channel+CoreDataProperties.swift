//
//  Channel+CoreDataProperties.swift
//  
//
//  Created by Gordon Pearlman on 3/12/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Channel {

    @NSManaged var dmx16bit: NSNumber?
    @NSManaged var name: String?
    @NSManaged var style: String?
    @NSManaged var number: String?

}
