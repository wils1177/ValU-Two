//
//  BalanceData+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 8/28/19.
//
//

import Foundation
import CoreData

@objc(BalanceData)
public class BalanceData: NSManagedObject{
    
    
    convenience init(balance : BalanceJSON, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "BalanceData", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.available = balance.available ?? 0
        self.current = balance.current
        self.limit = balance.limit ?? 0
        
        
    }
    

}
