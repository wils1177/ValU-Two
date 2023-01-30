//
//  IncomeStreamData+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/5/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension IncomeStreamData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IncomeStreamData> {
        return NSFetchRequest<IncomeStreamData>(entityName: "IncomeStreamData")
    }

    @NSManaged public var confidence: Float
    @NSManaged public var days: Double
    @NSManaged public var monthlyIncome: Double
    @NSManaged public var name: String?
    @NSManaged public var incomeData: IncomeData?

}

extension IncomeStreamData : Identifiable {

}
