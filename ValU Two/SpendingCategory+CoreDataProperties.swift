//
//  SpendingCategory+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 1/24/20.
//
//

import Foundation
import CoreData


extension SpendingCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpendingCategory> {
        return NSFetchRequest<SpendingCategory>(entityName: "SpendingCategory")
    }

    @NSManaged public var amountSpent: Float
    @NSManaged public var initialThirtyDaysSpent: Float
    @NSManaged public var limit: Float
    @NSManaged public var selected: Bool
    @NSManaged public var category: Category?
    @NSManaged public var subSpendingCategories: NSSet?

}

// MARK: Generated accessors for subSpendingCategories
extension SpendingCategory {

    @objc(addSubSpendingCategoriesObject:)
    @NSManaged public func addToSubSpendingCategories(_ value: SpendingCategory)

    @objc(removeSubSpendingCategoriesObject:)
    @NSManaged public func removeFromSubSpendingCategories(_ value: SpendingCategory)

    @objc(addSubSpendingCategories:)
    @NSManaged public func addToSubSpendingCategories(_ values: NSSet)

    @objc(removeSubSpendingCategories:)
    @NSManaged public func removeFromSubSpendingCategories(_ values: NSSet)

}
