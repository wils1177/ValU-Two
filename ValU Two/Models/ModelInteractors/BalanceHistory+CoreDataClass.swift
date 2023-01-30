//
//  BalanceHistory+CoreDataClass.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/17/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData

@objc(BalanceHistory)
public class BalanceHistory: NSManagedObject {
    
    convenience init(accountId : String, date: Date, balance: Double, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "BalanceHistory", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.accountId = accountId
        self.date = date
        self.balance = balance
        
    }

}
