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
}

enum OnboardingStatus : String{
    case started = "Started"
    case bankConnected = "BankConnected"
    case incomeEntered = "IncomeEntered"
    case savingsEntered = "SavingsEntered"
    case completed = "Completed"
}

@objc(Budget)
public class Budget: NSManagedObject, NSCopying {
    
    
    
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
        newBudget.onboardingStatus = self.onboardingStatus
        newBudget.id = UUID()
        
        return newBudget
    }
    
    
    
    convenience init(context: NSManagedObjectContext){
        
        print("creating budget")
        let entity = NSEntityDescription.entity(forEntityName: "Budget", in: context)
        self.init(entity: entity!, insertInto: context)
        self.active = true
        self.spent = 0.0
        self.id = UUID()
        self.onboardingStatus = OnboardingStatus.started.rawValue
        setTimeFrame(timeFrame: TimeFrame.monthly)
        self.generateSpendingCategories()

        
    }
    
    func generateSpendingCategories(){
        
        let categoryData = CategoriesData()
        let categoryList = categoryData.getCategoriesList()
        

        
        //Create a spending category for ALL categoryies
        createSpendingCategory(categories: categoryList.categories)
        
    }
    
    func createSpendingCategory(categories: [CategoryEntry]){
        
        for category in categories{
            
            let newSpendingCategory = DataManager().createNewSpendingCategory(categoryEntry: category)
            self.addToSpendingCategories(newSpendingCategory)
            
            if category.subCategories != nil{
                for subCategory in category.subCategories!{
                    let newSpendingSubCategory = DataManager().createNewSpendingCategory(categoryEntry: subCategory)
                    newSpendingCategory.addToSubSpendingCategories(newSpendingSubCategory)
                    newSpendingSubCategory.budget = self
                }
            }
            
        }
        
    }
    
    func getSubSpendingCategories() -> [SpendingCategory]{
        
        var categoriesToReturn = [SpendingCategory]()
        
        for case let category as SpendingCategory in self.spendingCategories!{
            
            if category.subSpendingCategories != nil{
                for case let subCategory as SpendingCategory in category.subSpendingCategories!{
                    categoriesToReturn.append(subCategory)
                }
            }
            
        }
        
        return categoriesToReturn
    }
    
    func getParentSpendingCategories() -> [SpendingCategory]{
        
        var categoriesToReturn = [SpendingCategory]()
        
        for case let category as SpendingCategory in self.spendingCategories!{
            
            if category.subSpendingCategories != nil && category.subSpendingCategories!.count > 0{
                categoriesToReturn.append(category)
            }
            
        }
        
        return categoriesToReturn
        
    }
    
    func getAllSpendingCategories() -> [SpendingCategory]{
        
        var categoriesToReturn = [SpendingCategory]()
        
        for case let category as SpendingCategory in self.spendingCategories!{
            
            categoriesToReturn.append(category)
            
            if category.subSpendingCategories != nil{
                for case let subCategory as SpendingCategory in category.subSpendingCategories!{
                    categoriesToReturn.append(subCategory)
                }
            }
            
        }
        
        return categoriesToReturn
        
    }
    
    
        
    
    func calculateSavingsAmount(percentageOfAmount: Float) -> Float{
        var calculation = percentageOfAmount * self.amount
        calculation = (calculation*100).rounded()/100
        return calculation
    }
    
    
    func setTimeFrame(timeFrame: TimeFrame) {
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
        let startOfMonth = Calendar.current.date(from: comp)
        
        if timeFrame == TimeFrame.monthly{
            self.timeFrame = TimeFrame.monthly.rawValue
            self.startDate = startOfMonth
            self.endDate = Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth!)
        }
        else if timeFrame == TimeFrame.semiMonthly{
            //Todo: A real implementation around semi monthly
            print("Semi Monthly does not really work yet")
            self.timeFrame = TimeFrame.semiMonthly.rawValue
            self.startDate = Date()
            self.endDate = Calendar.current.date(byAdding: .day, value: 15, to: Date())
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
    
    
    
    func updateAmountSpent(){
        print("updating the amount spent")
        self.spent = 0.0
        calculateSpendTotal()
        let spendingCategories = getSubSpendingCategories()
        for category in spendingCategories{
            category.reCalculateAmountSpent()
        }
        print("finished updating the amount spent")
    }
    
    func calculateSpendTotal(){
        
        for transaction in self.transactions?.allObjects as! [Transaction]{
            if transaction.amount > 0{
                self.spent = self.spent + Float(transaction.amount)
            }
            
        }
   
    }
    
    func deSelectCategory(name: String){
        let categories = getSubSpendingCategories()
        for category in categories{
            if category.name! == name{
                category.selected.toggle()
            }
        }
    }
    
    func calculateOtherSpent() -> Double{
        
        var otherTotal = 0.0
        for transaction in self.transactions?.allObjects as! [Transaction]{
            
            var isSelected = false
            for match in transaction.categoryMatches?.allObjects as! [SpendingCategory]{
                if match.selected{
                    isSelected = true
                }
            }
            
            if !isSelected && transaction.amount > 0{
                otherTotal = otherTotal + transaction.amount
            }
            
        }
        
        return otherTotal
        
    }
    
    
    

}
