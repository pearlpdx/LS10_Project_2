//
//  Group+CoreDataProperties.swift
//  LS10_Project
//
//  Created by Gordon Pearlman on 4/2/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Group {

    @NSManaged var name: String?
    @NSManaged var section: String?

}
