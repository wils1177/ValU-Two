//
//  ItemData+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 9/2/19.
//
//

import Foundation
import CoreData


extension ItemData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemData> {
        return NSFetchRequest<ItemData>(entityName: "ItemData")
    }

    @NSManaged public var billedProducts: NSArray?
    @NSManaged public var error: String?
    @NSManaged public var institutionId: String?
    @NSManaged public var itemId: String?

}
