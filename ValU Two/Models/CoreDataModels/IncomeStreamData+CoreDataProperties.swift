//
//  IncomeStreamData+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 12/18/19.
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

}
