//
//  IncomeData+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/5/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension IncomeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IncomeData> {
        return NSFetchRequest<IncomeData>(entityName: "IncomeData")
    }

    @NSManaged public var lastYearBeforeIncomeTax: Double
    @NSManaged public var lastYearIncome: Double
    @NSManaged public var projectedYearlyIncome: Double
    @NSManaged public var projectedYearlyIncomeBeforeTax: Double
    @NSManaged public var incomeStreams: NSSet?

}

// MARK: Generated accessors for incomeStreams
extension IncomeData {

    @objc(addIncomeStreamsObject:)
    @NSManaged public func addToIncomeStreams(_ value: IncomeStreamData)

    @objc(removeIncomeStreamsObject:)
    @NSManaged public func removeFromIncomeStreams(_ value: IncomeStreamData)

    @objc(addIncomeStreams:)
    @NSManaged public func addToIncomeStreams(_ values: NSSet)

    @objc(removeIncomeStreams:)
    @NSManaged public func removeFromIncomeStreams(_ values: NSSet)

}

extension IncomeData : Identifiable {

}
