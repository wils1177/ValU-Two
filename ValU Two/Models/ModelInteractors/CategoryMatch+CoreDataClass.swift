//
//  CategoryMatch+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 3/28/20.
//
//

import Foundation
import CoreData

@objc(CategoryMatch)
public class CategoryMatch: NSManagedObject {
    
    convenience init(transaction : Transaction, category: SpendingCategory, amount: Float,  context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "CategoryMatch", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.transaction = transaction
        self.spendingCategory = category
        self.amount = amount
        self.id = UUID()
        
    }

}
