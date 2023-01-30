//
//  SpendingCategory+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/5/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension SpendingCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpendingCategory> {
        return NSFetchRequest<SpendingCategory>(entityName: "SpendingCategory")
    }

    @NSManaged public var colorCode: Int32
    @NSManaged public var contains: [String]?
    @NSManaged public var hidden: Bool
    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var initialThirtyDaysSpent: Float
    @NSManaged public var limit: Float
    @NSManaged public var matchDepth: Int32
    @NSManaged public var name: String?
    @NSManaged public var selected: Bool
    @NSManaged public var spent: Float
    @NSManaged public var budgetCategory: NSSet?
    @NSManaged public var subSpendingCategories: NSSet?
    @NSManaged public var transactionMatches: NSSet?
    @NSManaged public var transactionRules: NSSet?
    @NSManaged public var parentSpendingCategory: SpendingCategory?

}

// MARK: Generated accessors for budgetCategory
extension SpendingCategory {

    @objc(addBudgetCategoryObject:)
    @NSManaged public func addToBudgetCategory(_ value: BudgetCategory)

    @objc(removeBudgetCategoryObject:)
    @NSManaged public func removeFromBudgetCategory(_ value: BudgetCategory)

    @objc(addBudgetCategory:)
    @NSManaged public func addToBudgetCategory(_ values: NSSet)

    @objc(removeBudgetCategory:)
    @NSManaged public func removeFromBudgetCategory(_ values: NSSet)

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

// MARK: Generated accessors for transactionMatches
extension SpendingCategory {

    @objc(addTransactionMatchesObject:)
    @NSManaged public func addToTransactionMatches(_ value: CategoryMatch)

    @objc(removeTransactionMatchesObject:)
    @NSManaged public func removeFromTransactionMatches(_ value: CategoryMatch)

    @objc(addTransactionMatches:)
    @NSManaged public func addToTransactionMatches(_ values: NSSet)

    @objc(removeTransactionMatches:)
    @NSManaged public func removeFromTransactionMatches(_ values: NSSet)

}

// MARK: Generated accessors for transactionRules
extension SpendingCategory {

    @objc(addTransactionRulesObject:)
    @NSManaged public func addToTransactionRules(_ value: TransactionRule)

    @objc(removeTransactionRulesObject:)
    @NSManaged public func removeFromTransactionRules(_ value: TransactionRule)

    @objc(addTransactionRules:)
    @NSManaged public func addToTransactionRules(_ values: NSSet)

    @objc(removeTransactionRules:)
    @NSManaged public func removeFromTransactionRules(_ values: NSSet)

}

extension SpendingCategory : Identifiable {

}
