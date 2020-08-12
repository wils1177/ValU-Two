//
//  BudgetCategory+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension BudgetCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetCategory> {
        return NSFetchRequest<BudgetCategory>(entityName: "BudgetCategory")
    }

    @NSManaged public var limit: Double
    @NSManaged public var id: UUID?
    @NSManaged public var budgetSection: BudgetSection?
    @NSManaged public var spendingCategory: SpendingCategory?

}
