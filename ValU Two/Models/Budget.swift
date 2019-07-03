//
//  Budget.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/8/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

enum timeFrame {
    case monthly
    case semiMonthly
}

class Budget{
    
    //Member Variables
    var amount: Float?
    var budgetTimeFrame: timeFrame
    var savingsPercent: Float?
    var spengingCategories: [SpendingCategory]?
    
    init(amount: Float?, budgetTimeFrame: timeFrame){
        
        self.amount = amount
        self.budgetTimeFrame = budgetTimeFrame
        self.spengingCategories = generateDefaultCategories()
        self.savingsPercent = 0.2
        
    }
    
    init (){
        self.budgetTimeFrame = timeFrame.monthly
        self.savingsPercent = 0.2
    }
    
    func calculateSavingsAmount(percentageOfAmount: Float) -> Float{
        var calculation = percentageOfAmount * self.amount!
        calculation = (calculation*100).rounded()/100
        return calculation
    }
    
    func getAmount() -> Float?{
        
        return self.amount
        
    }
    
    func setSavingsPercent(savingsPercent: Float){
        self.savingsPercent = savingsPercent
    }
    
    func getSavingsPercent() -> Float{
        return self.savingsPercent!
    }
    
    func getSpendingCategories() -> [SpendingCategory]{
        return self.spengingCategories!
    }
    
    func getTimeFrame() -> timeFrame{
        return self.budgetTimeFrame
    }
    
    func generateDefaultCategories() -> [SpendingCategory]{
        
        let categoriesToGenerate = ["Food", "Rent", "Fun"]
        var toReturn = [SpendingCategory]()
        
        for category in categoriesToGenerate{
            let newSpendingCategory = SpendingCategory(name: category, limit: 100.00, amountSpent: 0.0)
            toReturn.append(newSpendingCategory)
        }
        
        return toReturn
        
    }
    
    func updateSpendingCategoryLimit(index: Int, amount: String?){
        
        let categoryToUpdate = findSpendingCategoryByIndex(index: index)
        
        if amount != nil && amount != "" {
            categoryToUpdate.setLimit(amount: Float(amount!)!)

        }
        
        
    }
    
    func updateSpendingCategoryName(index: Int, name: String?){
        
        let categoryToUpdate = findSpendingCategoryByIndex(index: index)
        
        if name != nil && name != "" {
            categoryToUpdate.setName(name: name!)
        }
        
    }
    
    
    func findSpendingCategoryByIndex(index: Int)  -> SpendingCategory {
        
        return self.spengingCategories![index]
       
    }
    
    func addNewSpendingCategory(name:String){
        let newSpendingCategory = SpendingCategory(name:name, limit: 100.00, amountSpent: 0.0)
        self.spengingCategories?.append(newSpendingCategory)
    }
    
    func isAmountEmpty() -> Bool {
        if self.amount == nil {
            return true
        }
        else{
            return false
        }
    }
    
}
