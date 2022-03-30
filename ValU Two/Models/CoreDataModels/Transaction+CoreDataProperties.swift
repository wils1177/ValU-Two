//
//  Transaction+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/22/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
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
    @NSManaged public var isHidden: Bool
    @NSManaged public var itemId: String?
    @NSManaged public var merchantName: String?
    @NSManaged public var name: String?
    @NSManaged public var pending: Bool
    @NSManaged public var plaidCategories: [String]?
    @NSManaged public var transactionId: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var budget: Budget?
    @NSManaged public var categoryMatches: NSSet?
    @NSManaged public var dateCache: NSSet?
    @NSManaged public var location: Location?

}

// MARK: Generated accessors for categoryMatches
extension Transaction {

    @objc(addCategoryMatchesObject:)
    @NSManaged public func addToCategoryMatches(_ value: CategoryMatch)

    @objc(removeCategoryMatchesObject:)
    @NSManaged public func removeFromCategoryMatches(_ value: CategoryMatch)

    @objc(addCategoryMatches:)
    @NSManaged public func addToCategoryMatches(_ values: NSSet)

    @objc(removeCategoryMatches:)
    @NSManaged public func removeFromCategoryMatches(_ values: NSSet)

}

// MARK: Generated accessors for dateCache
extension Transaction {

    @objc(addDateCacheObject:)
    @NSManaged public func addToDateCache(_ value: TransactionDateCache)

    @objc(removeDateCacheObject:)
    @NSManaged public func removeFromDateCache(_ value: TransactionDateCache)

    @objc(addDateCache:)
    @NSManaged public func addToDateCache(_ values: NSSet)

    @objc(removeDateCache:)
    @NSManaged public func removeFromDateCache(_ values: NSSet)

}

extension Transaction : Identifiable {

}
