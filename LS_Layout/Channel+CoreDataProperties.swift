//
//  Channel+CoreDataProperties.swift
//  LS10_Project
//
//  Created by Home on 3/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Channel {

    @NSManaged var dmx16bit: NSNumber?
    @NSManaged var group: String?
    @NSManaged var name: String?
    @NSManaged var number: String?
    @NSManaged var style: String?

}
