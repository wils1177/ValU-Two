//
//  TransactionDateCache+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 4/5/20.
//
//

import Foundation
import CoreData


extension TransactionDateCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionDateCache> {
        return NSFetchRequest<TransactionDateCache>(entityName: "TransactionDateCache")
    }

    @NSManaged public var income: Float
    @NSManaged public var expenses: Float
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var timeFrame: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension TransactionDateCache {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
