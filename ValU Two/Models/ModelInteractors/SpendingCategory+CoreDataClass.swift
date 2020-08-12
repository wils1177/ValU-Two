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
        let newSpendingCategory = DataManager().createNewSpendingCategory(icon: self.icon!, name: self.name!)
        newSpendingCategory.contains = self.contains
        newSpendingCategory.limit = self.limit
        newSpendingCategory.spent = self.spent
        newSpendingCategory.initialThirtyDaysSpent = self.initialThirtyDaysSpent
        newSpendingCategory.selected = self.selected
        newSpendingCategory.id = UUID()
        newSpendingCategory.matchDepth = self.matchDepth
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
        self.matchDepth = Int32(categoryEntry.matchDepth!)
        self.colorCode = Int32(categoryEntry.colorCode!)
        
        
    }
    
    convenience init(icon: String, name: String, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "SpendingCategory", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.name  = name
        self.icon = icon
        self.id = UUID()
        self.contains = [String]()
        self.limit = 0.0
        self.spent = 0.0
        self.initialThirtyDaysSpent = 0.0
        self.selected = false
        self.matchDepth = Int32(0)
        self.colorCode = Int32(0)
        
        
    }
    
    

    
    convenience init(context: NSManagedObjectContext){
        
        let entity = NSEntityDescription.entity(forEntityName: "SpendingCategory", in: context)
        self.init(entity: entity!, insertInto: context)
        
    }
    
    func getAmountSpentForTimeFrame(startDate: Date, endDate: Date) -> Double{
        var amountSpent = 0.0
        for match in self.transactionMatches?.allObjects as! [CategoryMatch]{
            let transaction = match.transaction!
            if CommonUtils.isWithinDates(transaction: transaction, start: startDate, end: endDate){
                amountSpent = amountSpent + Double(match.amount)
            }
        }
        return amountSpent
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
