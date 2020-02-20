//
//  Transaction+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 2/16/20.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var accountId: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var itemId: String?
    @NSManaged public var name: String?
    @NSManaged public var pending: Bool
    @NSManaged public var plaidCategories: [String]?
    @NSManaged public var transactionId: String?
    @NSManaged public var categoryMatches: NSSet?
    @NSManaged public var location: Location?
    @NSManaged public var budget: Budget?

}

// MARK: Generated accessors for categoryMatches
extension Transaction {

    @objc(addCategoryMatchesObject:)
    @NSManaged public func addToCategoryMatches(_ value: SpendingCategory)

    @objc(removeCategoryMatchesObject:)
    @NSManaged public func removeFromCategoryMatches(_ value: SpendingCategory)

    @objc(addCategoryMatches:)
    @NSManaged public func addToCategoryMatches(_ values: NSSet)

    @objc(removeCategoryMatches:)
    @NSManaged public func removeFromCategoryMatches(_ values: NSSet)

}
