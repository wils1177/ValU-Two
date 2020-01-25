//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 1/24/20.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var contains: [String]?
    @NSManaged public var icon: String?
    @NSManaged public var name: String?
    @NSManaged public var subCategories: NSSet?
    @NSManaged public var transactions: NSSet?
    @NSManaged public var spendingCategory: SpendingCategory?

}

// MARK: Generated accessors for subCategories
extension Category {

    @objc(addSubCategoriesObject:)
    @NSManaged public func addToSubCategories(_ value: Category)

    @objc(removeSubCategoriesObject:)
    @NSManaged public func removeFromSubCategories(_ value: Category)

    @objc(addSubCategories:)
    @NSManaged public func addToSubCategories(_ values: NSSet)

    @objc(removeSubCategories:)
    @NSManaged public func removeFromSubCategories(_ values: NSSet)

}

// MARK: Generated accessors for transactions
extension Category {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
