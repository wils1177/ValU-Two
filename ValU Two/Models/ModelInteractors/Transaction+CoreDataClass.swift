//
//  Transaction+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 8/28/19.
//
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
    

    convenience init(transaction: TransactionJSON, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "Transaction", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.accountId = (transaction.accountId)
        self.amount = (transaction.amount)
        self.date = (transaction.date)
        self.name = transaction.name
        self.location = Location(location: transaction.location, context: context)
        self.pending = transaction.pending
        self.transactionId = transaction.transactionId
        self.plaidCategories = transaction.plaidCategories
        
    }

    
}

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let context = CodingUserInfoKey(rawValue: "context")
}
