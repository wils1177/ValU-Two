//
//  BudgetSection+CoreDataClass.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData

@objc(BudgetSection)
public class BudgetSection: NSManagedObject, NSCopying {
    
    convenience init(name : String, icon: String, colorCode: Int, order: Int, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "BudgetSection", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.order = Int64(order)
        self.name = name
        self.icon = icon
        self.colorCode = Int32(colorCode)
        self.id = UUID()

    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        
        let newBudgetSection = DataManager().createBudgetSection(name: self.name!, icon: self.icon!, colorCode: Int(self.colorCode), order: Int(self.order))
        
        for budgetCategory in self.budgetCategories?.allObjects as! [BudgetCategory]{
            let newBudgetCategory = budgetCategory.copy() as! BudgetCategory
            newBudgetSection.addToBudgetCategories(newBudgetCategory)
        }
        
        return newBudgetSection
        
    }
    
    func getLimit() -> Double{
        
        var total = 0.0
        for child in self.budgetCategories?.allObjects as? [BudgetCategory] ?? [BudgetCategory](){
            total = child.limit + total
        }
        return total
    }
    
    func getSpent() -> Double{
        
        var total = 0.0
        for child in self.budgetCategories?.allObjects as! [BudgetCategory]{
            
            //if child.limit > 0.0{
                total = child.getAmountSpent() + total
            //}
            
        }
        return total
    }
    
    func getInitialSpent() -> Double{
        let children = self.budgetCategories?.allObjects as! [BudgetCategory]
        var total = 0.0
        for child in children{
            
            total = Double(child.spendingCategory!.initialThirtyDaysSpent) + total

        }
        return total
    }
    
    func getPercentageSpent() -> Double{
        let limit = getLimit()
        let spent = getSpent()
        
        if limit != 0.0{
           return spent / limit
        }
        else{
            return 0.0
        }
        
    }
    
    func getBudgetCategories() -> [BudgetCategory]{
        return (self.budgetCategories?.allObjects as! [BudgetCategory]).sorted(by: { $0.order < $1.order })
    }

}
