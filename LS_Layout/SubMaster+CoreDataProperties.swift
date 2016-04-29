//
//  SubMaster+CoreDataProperties.swift
//  LS10_Project
//
//  Created by Home on 4/25/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SubMaster {

    @NSManaged var exclude: Bool
    @NSManaged var image: NSData?
    @NSManaged var indOnly: Bool
    @NSManaged var name: String?
    @NSManaged var number: Int16
    @NSManaged var time: Int32
    @NSManaged var fixtureStores: NSSet?

}
