//
//  Channel+CoreDataProperties.swift
//  LS10_Project
//
//  Created by Home on 2/11/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Channel {

    @NSManaged var name: String?
    @NSManaged var style: String?
    @NSManaged var dmx16bit: NSNumber?

}
