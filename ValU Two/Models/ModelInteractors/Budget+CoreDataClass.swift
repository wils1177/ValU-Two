//
//  Budget+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 9/7/19.
//
//

import Foundation
import CoreData

enum TimeFrame: Int32 {
    case monthly
    case semiMonthly
    case weekly
}

enum OnboardingStatus : String{
    case started = "Started"
    case bankConnected = "BankConnected"
    case incomeEntered = "IncomeEntered"
    case savingsEntered = "SavingsEntered"
    case completed = "Completed"
}

@objc(Budget)
public class Budget: NSManagedObject, NSCopying, Identifiable {
    
    
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let newBudget = DataManager().createNewBudget()
        newBudget.active = self.active
        newBudget.amount = self.amount
        newBudget.endDate = self.endDate
        newBudget.startDate = self.startDate
        newBudget.savingsPercent = self.savingsPercent
        newBudget.timeFrame = self.timeFrame
        newBudget.inflow = self.inflow
        newBudget.spent = self.spent
        newBudget.name = self.name
        newBudget.repeating = self.repeating
        newBudget.id = UUID()
        
        return newBudget
    }
    
    
    
    convenience init(context: NSManagedObjectContext){
        
        print("creating budget")
        let entity = NSEntityDescription.entity(forEntityName: "Budget", in: context)
        self.init(entity: entity!, insertInto: context)
        self.active = false
        self.spent = 0.0
        self.id = UUID()
        self.name = "Placeholder"
        self.timeFrame = -1
        self.generateDefaultBudgetSections()

    }
    
    func generateDefaultBudgetSections(){
        let parentSpendingCategories = SpendingCategoryService().getParentSpendingCategories()
        
        for parent in parentSpendingCategories{
            let name = parent.name!
            let icon = parent.icon!
            
            if name != "Custom"{
                let newBudgetSection = DataManager().createBudgetSection(name: name, icon: icon, colorCode: Int(parent.colorCode))
                self.addToBudgetSection(newBudgetSection)
                
                for subCategory in parent.subSpendingCategories?.allObjects as! [SpendingCategory]{
                    let newBudgetCategory = DataManager().createBudgetCategory(category: subCategory)
                    newBudgetSection.addToBudgetCategories(newBudgetCategory)
                }
            }
            
        }
        DataManager().saveDatabase()
        
    }
    
    func getBudgetSections() -> [BudgetSection]{
        return self.budgetSection?.allObjects as! [BudgetSection]
    }
    
    func getBudgetCategories() -> [BudgetCategory]{
        var budgetCategories = [BudgetCategory]()
        let sections = self.getBudgetSections()
        for section in sections{
            for category in section.budgetCategories?.allObjects as! [BudgetCategory]{
                budgetCategories.append(category)
            }
        }
        
        return budgetCategories
    }
    
    
        
    
    func calculateSavingsAmount(percentageOfAmount: Float) -> Float{
        var calculation = percentageOfAmount * self.amount
        calculation = (calculation*100).rounded()/100
        return calculation
    }
    
    
    func setTimeFrame(timeFrame: TimeFrame) {
        
        let today = Date()
        
        if timeFrame == TimeFrame.monthly{
            self.timeFrame = TimeFrame.monthly.rawValue
            self.startDate = today.startOfMonth!
            self.endDate = today.endOfMonth!
        }
        else if timeFrame == TimeFrame.semiMonthly{
            
            let startOfMonth = today.startOfMonth!
            let fifteenth = today.fifteenthOfMonth!
            let endOfMonth = today.endOfMonth!
            
            if (startOfMonth ... fifteenth).contains(today){
                self.startDate = startOfMonth
                self.endDate = fifteenth
            }
            else{
                self.startDate = fifteenth
                self.endDate = endOfMonth
            }
            
            
            self.timeFrame = TimeFrame.semiMonthly.rawValue
            
        }
        else if timeFrame == TimeFrame.weekly{
            
            self.startDate = today.startOfWeek!
            self.endDate = today.endOfWeek!
            
            self.timeFrame = TimeFrame.weekly.rawValue
        }
        
        
    }
    
    func incrementTimeFrame(){
        
        
        if self.timeFrame == TimeFrame.monthly.rawValue{
            
            let newStartDate = Calendar.current.date(byAdding: .month, value: 1, to: self.startDate!)
            let newEndDate = Calendar.current.date(byAdding: .month, value: 1, to: self.endDate!)
            
            self.startDate = newStartDate
            self.endDate = newEndDate
            
        }
        
    }
    
    
    func getAmountAvailable() -> Float {
        return self.amount * (1 - self.savingsPercent)
    }
    
    
    func getAmountSpent() -> Float{
        var spent = 0.0
        for section in self.budgetSection?.allObjects as! [BudgetSection]{
            spent = spent + section.getSpent()
        }
        return Float(spent)
    }
    
    func updateAmountSpent(){
        //print("updating the amount spent")
        //self.spent = 0.0
        //let spendingCategories = getSubSpendingCategories()
        //for category in spendingCategories{
        //    category.reCalculateAmountSpent()

        //}
        //print("finished updating the amount spent")
    }
    
    /*
    func deSelectCategory(name: String){
        let categories = getSubSpendingCategories()
        for category in categories{
            if category.name! == name{
                category.selected.toggle()
            }
        }
    }
    */
    
    

    
    
    

}
