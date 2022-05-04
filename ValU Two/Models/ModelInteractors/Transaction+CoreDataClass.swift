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
    

    convenience init(transaction: TransactionJSON, itemId: String, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "Transaction", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.accountId = (transaction.accountId)
        self.amount = (transaction.amount)
        
        if transaction.authDate != nil{
            self.date = getDate(dateString: transaction.authDate!)
        }
        else{
            self.date = getDate(dateString: transaction.date)
        }
        
        self.name = transaction.name
        self.location = Location(location: transaction.location, context: context)
        self.pending = transaction.pending
        self.transactionId = transaction.transactionId
        self.plaidCategories = transaction.plaidCategories
        self.itemId = itemId
        self.isHidden = false
        self.categoryMatches = NSSet(array: [CategoryMatch]())
        self.merchantName = transaction.merchantName
        self.createdDate = Date()
        
    }
    
    func getDate(dateString : String) -> Date? {
        print(dateString)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dateString)!
    
        
        return date
    }
    
    

    
}

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let context = CodingUserInfoKey(rawValue: "context")
}
