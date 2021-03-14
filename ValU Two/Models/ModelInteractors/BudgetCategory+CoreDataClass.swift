//
//  BudgetCategory+CoreDataClass.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject, NSCopying {
    
    convenience init(category : SpendingCategory, order: Int, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "BudgetCategory", in: context)
        self.init(entity: entity!, insertInto: context)
        self.order = Int64(order)
        self.limit = 0.0
        self.spendingCategory = category
        
        self.id = UUID()
        

    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        
        let newBudgetCategory = DataManager().createBudgetCategory(category: self.spendingCategory!, order: Int(self.order))
        newBudgetCategory.limit = self.limit
        return newBudgetCategory
        
    }
    
    func getAmountSpent() -> Double{
        let startDate = self.budgetSection!.budget!.startDate
        let endDate = self.budgetSection!.budget!.endDate
        
        return self.spendingCategory!.getAmountSpentForTimeFrame(startDate: startDate!, endDate: endDate!)
    }

}
