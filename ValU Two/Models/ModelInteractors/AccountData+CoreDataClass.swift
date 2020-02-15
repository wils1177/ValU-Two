//
//  AccountData+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 8/28/19.
//
//

import Foundation
import CoreData

@objc(AccountData)
public class AccountData: NSManagedObject{
    
    convenience init(account : AccountJSON, itemId: String, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "AccountData", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.accountId = account.accountId
        self.balances = BalanceData(balance: account.balances, context: context)
        self.mask = account.mask
        self.name = account.name
        self.officialName = account.officialName
        self.type = account.type
        self.subType = account.subType
        self.itemId = itemId
        
        
    }

}
