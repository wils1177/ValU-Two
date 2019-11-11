//
//  Transaction+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 11/10/19.
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
    @NSManaged public var name: String?
    @NSManaged public var pending: Bool
    @NSManaged public var plaidCategories: [String]?
    @NSManaged public var transactionId: String?
    @NSManaged public var location: Location?

}
