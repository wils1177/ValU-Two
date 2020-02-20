//
//  SpendingCategory+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 9/7/19.
//
//

import Foundation
import CoreData

@objc(SpendingCategory)
public class SpendingCategory: NSManagedObject {
    
    convenience init(categoryEntry: CategoryEntry, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "SpendingCategory", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.name  = categoryEntry.name
        self.icon = categoryEntry.icon
        self.contains = categoryEntry.contains
        self.limit = 0.0
        self.amountSpent = 0.0
        self.initialThirtyDaysSpent = 0.0
        self.selected = false
        
        
    }
    
    func reCalculateAmountSpent(){
        self.amountSpent = 0.0
        for transaction in self.transactions?.allObjects as! [Transaction]{

            if isWithinBudgetDates(transactionDate: transaction.date!){
                if transaction.amount > 0{
                    self.amountSpent  = self.amountSpent +  Float(transaction.amount)
                }
                
                
            }
            
        }
    }
    
    func isWithinBudgetDates(transactionDate: Date) -> Bool{
        
        let startDate = self.budget!.startDate!
        let endDate = self.budget!.endDate!
        
        return (startDate ... endDate).contains(transactionDate)
        
    }

}
