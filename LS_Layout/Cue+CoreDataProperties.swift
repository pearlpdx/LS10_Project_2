//
//  Cue+CoreDataProperties.swift
//  LS10_Project
//
//  Created by Home on 4/12/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Cue {

    @NSManaged var delayTime: Int32
    @NSManaged var downTime: Int32
    @NSManaged var image: NSData?
    @NSManaged var linkCue: NSDecimalNumber?
    @NSManaged var namex: String?
    @NSManaged var numberx: NSDecimalNumber?
    @NSManaged var uptime: Int32
    @NSManaged var waitTimex: Int32

}
