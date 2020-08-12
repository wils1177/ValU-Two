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
public class BudgetCategory: NSManagedObject {
    
    convenience init(category : SpendingCategory, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "BudgetCategory", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.limit = 0.0
        self.spendingCategory = category
        
        self.id = UUID()
        

    }
    
    func getAmountSpent() -> Double{
        let startDate = self.budgetSection!.budget!.startDate
        let endDate = self.budgetSection!.budget!.endDate
        
        return self.spendingCategory!.getAmountSpentForTimeFrame(startDate: startDate!, endDate: endDate!)
    }

}
