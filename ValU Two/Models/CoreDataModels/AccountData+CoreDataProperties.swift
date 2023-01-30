//
//  AccountData+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/5/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension AccountData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountData> {
        return NSFetchRequest<AccountData>(entityName: "AccountData")
    }

    @NSManaged public var accountId: String?
    @NSManaged public var itemId: String?
    @NSManaged public var mask: String?
    @NSManaged public var name: String?
    @NSManaged public var officialName: String?
    @NSManaged public var subType: String?
    @NSManaged public var type: String?
    @NSManaged public var balances: BalanceData?

}

extension AccountData : Identifiable {

}
