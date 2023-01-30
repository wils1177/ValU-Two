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
public class BudgetSection: NSManagedObject, NSCopying, Identifiable {
    
    convenience init(name : String, icon: String, colorCode: Int, order: Int, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "BudgetSection", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.order = Int64(order)
        self.name = name
        self.icon = icon
        self.colorCode = Int32(colorCode)
        self.id = UUID()
        self.spent = 0.0

    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        self.spent = getSpent()
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
    
    func getFreeLimit() -> Double{
        
        var total = 0.0
        for child in self.budgetCategories?.allObjects as? [BudgetCategory] ?? [BudgetCategory](){
            if !child.recurring{
                total = child.limit + total
            }
            
        }
        return total
    }
    
    func getRecurringLimit() -> Double{
        
        var total = 0.0
        for child in self.budgetCategories?.allObjects as? [BudgetCategory] ?? [BudgetCategory](){
            if child.recurring{
                total = child.limit + total
            }
            
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
    
    func getFreeSpent() -> Double{
        var total = 0.0
        
        for child in self.budgetCategories?.allObjects as! [BudgetCategory]{
            
            if !child.recurring{
                total = child.getAmountSpent() + total
            }
            
        }
        
        return total
    }
    
    func getRecurringSpent() -> Double{
        var total = 0.0
        for child in self.budgetCategories?.allObjects as! [BudgetCategory]{
            
            if child.recurring{
                total = child.getAmountSpent() + total
            }
            
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
            if spent > 0.0{
                return 1.0
            }
            else{
                return 0.0
            }
        }
        
    }
    
    func getBudgetCategories() -> [BudgetCategory]{
        return (self.budgetCategories?.allObjects as! [BudgetCategory]).sorted(by: { $0.order < $1.order })
    }
    
    func hasAnyRecurringCategories() -> Bool{
        let categories = getBudgetCategories()
        for cat in categories{
            if cat.recurring{
                return true
            }
        }
        return false
    }
    
    func hasAnyFreeCategories() -> Bool{
        let categories = getBudgetCategories()
        for cat in categories{
            if !cat.recurring{
                return true
            }
        }
        return false
    }

}
