//
//  Budget+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 4/12/20.
//
//

import Foundation
import CoreData


extension Budget {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budget> {
        return NSFetchRequest<Budget>(entityName: "Budget")
    }

    @NSManaged public var active: Bool
    @NSManaged public var amount: Float
    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var inflow: Float
    @NSManaged public var savingsPercent: Float
    @NSManaged public var spent: Float
    @NSManaged public var startDate: Date?
    @NSManaged public var timeFrame: Int32
    @NSManaged public var name: String?
    @NSManaged public var repeating: Bool
    @NSManaged public var spendingCategories: NSOrderedSet?
    @NSManaged public var transactions: NSSet?
    @NSManaged public var budgetTimeFrame: BudgetTimeFrame?

}

// MARK: Generated accessors for spendingCategories
extension Budget {

    @objc(insertObject:inSpendingCategoriesAtIndex:)
    @NSManaged public func insertIntoSpendingCategories(_ value: SpendingCategory, at idx: Int)

    @objc(removeObjectFromSpendingCategoriesAtIndex:)
    @NSManaged public func removeFromSpendingCategories(at idx: Int)

    @objc(insertSpendingCategories:atIndexes:)
    @NSManaged public func insertIntoSpendingCategories(_ values: [SpendingCategory], at indexes: NSIndexSet)

    @objc(removeSpendingCategoriesAtIndexes:)
    @NSManaged public func removeFromSpendingCategories(at indexes: NSIndexSet)

    @objc(replaceObjectInSpendingCategoriesAtIndex:withObject:)
    @NSManaged public func replaceSpendingCategories(at idx: Int, with value: SpendingCategory)

    @objc(replaceSpendingCategoriesAtIndexes:withSpendingCategories:)
    @NSManaged public func replaceSpendingCategories(at indexes: NSIndexSet, with values: [SpendingCategory])

    @objc(addSpendingCategoriesObject:)
    @NSManaged public func addToSpendingCategories(_ value: SpendingCategory)

    @objc(removeSpendingCategoriesObject:)
    @NSManaged public func removeFromSpendingCategories(_ value: SpendingCategory)

    @objc(addSpendingCategories:)
    @NSManaged public func addToSpendingCategories(_ values: NSOrderedSet)

    @objc(removeSpendingCategories:)
    @NSManaged public func removeFromSpendingCategories(_ values: NSOrderedSet)

}

// MARK: Generated accessors for transactions
extension Budget {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
