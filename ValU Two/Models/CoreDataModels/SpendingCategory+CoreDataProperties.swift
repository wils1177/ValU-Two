//
//  SpendingCategory+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 9/7/19.
//
//

import Foundation
import CoreData


extension SpendingCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpendingCategory> {
        return NSFetchRequest<SpendingCategory>(entityName: "SpendingCategory")
    }

    @NSManaged public var amountSpent: Float
    @NSManaged public var limit: Float
    @NSManaged public var category: Category?

}
