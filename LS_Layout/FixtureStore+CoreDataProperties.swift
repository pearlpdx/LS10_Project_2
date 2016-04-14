//
//  FixtureStore+CoreDataProperties.swift
//  LS10_Project
//
//  Created by Home on 4/14/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FixtureStore {

    @NSManaged var fixtureNumber: Int16
    @NSManaged var subNumber: Int16
    @NSManaged var toChannelStores: NSSet?
    @NSManaged var toSubMaster: SubMaster?

}
