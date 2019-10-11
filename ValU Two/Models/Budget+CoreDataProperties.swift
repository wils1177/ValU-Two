//
//  Budget+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 9/8/19.
//
//

import Foundation
import CoreData


extension Budget {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budget> {
        return NSFetchRequest<Budget>(entityName: "Budget")
    }

    @NSManaged public var savingsPercent: Float
    @NSManaged public var amount: Float
    @NSManaged public var timeFrame: Int32
    @NSManaged public var spendingCategories: NSSet?

}

// MARK: Generated accessors for spendingCategories
extension Budget {

    @objc(addSpendingCategoriesObject:)
    @NSManaged public func addToSpendingCategories(_ value: SpendingCategory)

    @objc(removeSpendingCategoriesObject:)
    @NSManaged public func removeFromSpendingCategories(_ value: SpendingCategory)

    @objc(addSpendingCategories:)
    @NSManaged public func addToSpendingCategories(_ values: NSSet)

    @objc(removeSpendingCategories:)
    @NSManaged public func removeFromSpendingCategories(_ values: NSSet)

}
