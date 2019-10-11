//
//  BalanceData+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 8/28/19.
//
//

import Foundation
import CoreData


extension BalanceData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BalanceData> {
        return NSFetchRequest<BalanceData>(entityName: "BalanceData")
    }

    @NSManaged public var available: Double
    @NSManaged public var current: Double
    @NSManaged public var limit: Double

}
