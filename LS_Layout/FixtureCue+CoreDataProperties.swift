//
//  FixtureCue+CoreDataProperties.swift
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

extension FixtureCue {

    @NSManaged var amberlevel: Float
    @NSManaged var blueLevel: Float
    @NSManaged var cueNumber: String?
    @NSManaged var fixNumber: Int32
    @NSManaged var greenLevel: Float
    @NSManaged var intensity: Float
    @NSManaged var redLevel: Float
    @NSManaged var whiteLevel: Float

}
