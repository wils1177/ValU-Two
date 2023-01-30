//
//  BalanceData+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/5/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
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
    @NSManaged public var account: AccountData?

}

extension BalanceData : Identifiable {

}
