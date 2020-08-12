//
//  BudgetSection+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension BudgetSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetSection> {
        return NSFetchRequest<BudgetSection>(entityName: "BudgetSection")
    }

    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var colorCode: Int32
    @NSManaged public var budget: Budget?
    @NSManaged public var budgetCategories: NSSet?

}

// MARK: Generated accessors for budgetCategories
extension BudgetSection {

    @objc(addBudgetCategoriesObject:)
    @NSManaged public func addToBudgetCategories(_ value: BudgetCategory)

    @objc(removeBudgetCategoriesObject:)
    @NSManaged public func removeFromBudgetCategories(_ value: BudgetCategory)

    @objc(addBudgetCategories:)
    @NSManaged public func addToBudgetCategories(_ values: NSSet)

    @objc(removeBudgetCategories:)
    @NSManaged public func removeFromBudgetCategories(_ values: NSSet)

}
