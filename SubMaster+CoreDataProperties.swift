//
//  SubMaster+CoreDataProperties.swift
//  
//
//  Created by Home on 3/29/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SubMaster {

    @NSManaged var number: Int16
    @NSManaged var name: String?
    @NSManaged var time: Float
    @NSManaged var noColor: Bool
    @NSManaged var exclude: Bool
    @NSManaged var indOnly: Bool

}
