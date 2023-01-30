//
//  BalanceHistory+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/17/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension BalanceHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BalanceHistory> {
        return NSFetchRequest<BalanceHistory>(entityName: "BalanceHistory")
    }

    @NSManaged public var accountId: String?
    @NSManaged public var date: Date?
    @NSManaged public var balance: Double

}

extension BalanceHistory : Identifiable {

}
