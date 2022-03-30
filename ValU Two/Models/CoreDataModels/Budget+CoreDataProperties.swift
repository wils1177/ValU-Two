//
//  Budget+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/8/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension Budget {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budget> {
        return NSFetchRequest<Budget>(entityName: "Budget")
    }

    @NSManaged public var active: Bool
    @NSManaged public var amount: Float
    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var inflow: Float
    @NSManaged public var name: String?
    @NSManaged public var repeating: Bool
    @NSManaged public var savingsPercent: Float
    @NSManaged public var spent: Float
    @NSManaged public var startDate: Date?
    @NSManaged public var timeFrame: Int32
    @NSManaged public var onboardingComplete: Bool
    @NSManaged public var budgetSection: NSSet?
    @NSManaged public var budgetTimeFrame: BudgetTimeFrame?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for budgetSection
extension Budget {

    @objc(addBudgetSectionObject:)
    @NSManaged public func addToBudgetSection(_ value: BudgetSection)

    @objc(removeBudgetSectionObject:)
    @NSManaged public func removeFromBudgetSection(_ value: BudgetSection)

    @objc(addBudgetSection:)
    @NSManaged public func addToBudgetSection(_ values: NSSet)

    @objc(removeBudgetSection:)
    @NSManaged public func removeFromBudgetSection(_ values: NSSet)

}

// MARK: Generated accessors for transactions
extension Budget {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

//extension Budget : Identifiable {

//}
