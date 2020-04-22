//
//  AccountData+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 2/9/20.
//
//

import Foundation
import CoreData


extension AccountData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountData> {
        return NSFetchRequest<AccountData>(entityName: "AccountData")
    }

    @NSManaged public var accountId: String?
    @NSManaged public var mask: String?
    @NSManaged public var name: String?
    @NSManaged public var officialName: String?
    @NSManaged public var subType: String?
    @NSManaged public var type: String?
    @NSManaged public var itemId: String?
    @NSManaged public var balances: BalanceData?

}
