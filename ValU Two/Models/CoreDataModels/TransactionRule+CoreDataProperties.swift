//
//  TransactionRule+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/6/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionRule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionRule> {
        return NSFetchRequest<TransactionRule>(entityName: "TransactionRule")
    }

    @NSManaged public var amountOverride: Double
    @NSManaged public var categories: [String]?
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var spendingCategories: NSSet?

}

// MARK: Generated accessors for spendingCategories
extension TransactionRule {

    @objc(addSpendingCategoriesObject:)
    @NSManaged public func addToSpendingCategories(_ value: SpendingCategory)

    @objc(removeSpendingCategoriesObject:)
    @NSManaged public func removeFromSpendingCategories(_ value: SpendingCategory)

    @objc(addSpendingCategories:)
    @NSManaged public func addToSpendingCategories(_ values: NSSet)

    @objc(removeSpendingCategories:)
    @NSManaged public func removeFromSpendingCategories(_ values: NSSet)

}

extension TransactionRule : Identifiable {

}
