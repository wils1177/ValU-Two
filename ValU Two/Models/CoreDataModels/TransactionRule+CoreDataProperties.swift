//
//  TransactionRule+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 1/29/20.
//
//

import Foundation
import CoreData


extension TransactionRule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionRule> {
        return NSFetchRequest<TransactionRule>(entityName: "TransactionRule")
    }

    @NSManaged public var name: String?
    @NSManaged public var amountOverride: Double
    @NSManaged public var categoriesOverride: NSSet?

}

// MARK: Generated accessors for categoriesOverride
extension TransactionRule {

    @objc(addCategoriesOverrideObject:)
    @NSManaged public func addToCategoriesOverride(_ value: Category)

    @objc(removeCategoriesOverrideObject:)
    @NSManaged public func removeFromCategoriesOverride(_ value: Category)

    @objc(addCategoriesOverride:)
    @NSManaged public func addToCategoriesOverride(_ values: NSSet)

    @objc(removeCategoriesOverride:)
    @NSManaged public func removeFromCategoriesOverride(_ values: NSSet)

}
