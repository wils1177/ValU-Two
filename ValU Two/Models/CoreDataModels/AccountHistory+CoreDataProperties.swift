//
//  AccountHistory+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/30/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension AccountHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountHistory> {
        return NSFetchRequest<AccountHistory>(entityName: "AccountHistory")
    }

    @NSManaged public var date: Date?
    @NSManaged public var accountId: String?
    @NSManaged public var balance: Double

}

extension AccountHistory : Identifiable {

}
