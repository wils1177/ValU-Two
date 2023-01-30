//
//  ItemData+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/5/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
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
    @NSManaged public var institutionName: String?
    @NSManaged public var itemId: String?

}

extension ItemData : Identifiable {

}
