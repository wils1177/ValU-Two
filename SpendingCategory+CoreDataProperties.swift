//
//  SpendingCategory+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 2/9/20.
//
//

import Foundation
import CoreData


extension SpendingCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpendingCategory> {
        return NSFetchRequest<SpendingCategory>(entityName: "SpendingCategory")
    }

    @NSManaged public var amountSpent: Float
    @NSManaged public var contains: [String]?
    @NSManaged public var icon: String?
    @NSManaged public var initialThirtyDaysSpent: Float
    @NSManaged public var limit: Float
    @NSManaged public var name: String?
    @NSManaged public var selected: Bool
    @NSManaged public var subSpendingCategories: NSSet?
    @NSManaged public var transactions: NSSet?
    @NSManaged public var budget: Budget?

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

// MARK: Generated accessors for transactions
extension SpendingCategory {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
