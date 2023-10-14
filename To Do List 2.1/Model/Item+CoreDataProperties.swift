//
//  Item+CoreDataProperties.swift
//  To Do List 2.1
//
//  Created by Vlad Klunduk on 14/10/2023.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}

extension Item : Identifiable {

}
