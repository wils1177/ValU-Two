//
//  BudgetTimeFrame+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 4/12/20.
//
//

import Foundation
import CoreData


extension BudgetTimeFrame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetTimeFrame> {
        return NSFetchRequest<BudgetTimeFrame>(entityName: "BudgetTimeFrame")
    }

    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var timeFrame: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var budget: Budget?
    @NSManaged public var nextTimeFrame: BudgetTimeFrame?

}
