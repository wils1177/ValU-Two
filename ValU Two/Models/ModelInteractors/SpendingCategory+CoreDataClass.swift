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
public class SpendingCategory: NSManagedObject, NSCopying {
    
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let newSpendingCategory = DataManager().createNewSpendingCategory()
        newSpendingCategory.name = self.name
        newSpendingCategory.icon = self.icon
        newSpendingCategory.contains = self.contains
        newSpendingCategory.limit = self.limit
        newSpendingCategory.spent = self.spent
        newSpendingCategory.initialThirtyDaysSpent = self.initialThirtyDaysSpent
        newSpendingCategory.selected = self.selected
        newSpendingCategory.id = UUID()
        return newSpendingCategory
    }
    
    
    convenience init(categoryEntry: CategoryEntry, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "SpendingCategory", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.name  = categoryEntry.name
        self.id = UUID()
        self.icon = categoryEntry.icon
        self.contains = categoryEntry.contains
        self.limit = 0.0
        self.spent = 0.0
        self.initialThirtyDaysSpent = 0.0
        self.selected = false
        self.colorCode = Int32(categoryEntry.colorCode!)
        
        
    }
    
    convenience init(context: NSManagedObjectContext){
        
        let entity = NSEntityDescription.entity(forEntityName: "SpendingCategory", in: context)
        self.init(entity: entity!, insertInto: context)
        
    }
    
    func getAmountSpent() -> Float{
        return calculateAmountSpent()
    }
    
    func calculateAmountSpent() -> Float{
        var newSpent = Float(0.0)
        for transactionMatch in self.transactionMatches?.allObjects as! [CategoryMatch]{
            
            if CommonUtils.isWithinBudget(transaction: transactionMatch.transaction!, budget: self.budget!){
                if transactionMatch.amount > 0{
                    newSpent  = newSpent +  transactionMatch.amount
                }  
                
            }
            
        }
        
        return newSpent
        
        
    }
    
    func isAnyChildSelected() -> Bool {
        var oneChildSelected = false
        for child in self.subSpendingCategories?.allObjects as! [SpendingCategory]{
            if child.limit > 0{
                oneChildSelected = true
            }
        }
        
        return oneChildSelected
    }
    
    func getSelectedChildren() -> [SpendingCategory] {
        let allChildren = self.subSpendingCategories?.allObjects as! [SpendingCategory]
        var selected = [SpendingCategory]()
        for child in allChildren{
            if child.selected{
                selected.append(child)
            }
        }
        
        return selected
    }

    


}
