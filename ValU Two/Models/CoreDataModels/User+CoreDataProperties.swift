//
//  User+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 9/7/19.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var accounts: NSSet?
    @NSManaged public var budget: Budget?

}

// MARK: Generated accessors for accounts
extension User {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: AccountData)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: AccountData)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}
