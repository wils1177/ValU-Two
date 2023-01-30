//
//  BudgetTimeFrame+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/5/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension BudgetTimeFrame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetTimeFrame> {
        return NSFetchRequest<BudgetTimeFrame>(entityName: "BudgetTimeFrame")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var startDate: Date?
    @NSManaged public var timeFrame: Int32
    @NSManaged public var budget: Budget?

}

extension BudgetTimeFrame : Identifiable {

}
