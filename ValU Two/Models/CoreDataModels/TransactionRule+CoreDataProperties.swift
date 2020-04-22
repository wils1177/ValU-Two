//
//  TransactionRule+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 2/9/20.
//
//

import Foundation
import CoreData


extension TransactionRule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionRule> {
        return NSFetchRequest<TransactionRule>(entityName: "TransactionRule")
    }

    @NSManaged public var amountOverride: Double
    @NSManaged public var name: String?
    @NSManaged public var categories: [String]?

}
