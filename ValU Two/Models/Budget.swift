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
    var spendingCategories = [SpendingCategory]()
    
    init(amount: Float?, budgetTimeFrame: timeFrame){
        
        self.amount = amount
        self.budgetTimeFrame = budgetTimeFrame
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
        return self.spendingCategories
    }
    
    func getTimeFrame() -> timeFrame{
        return self.budgetTimeFrame
    }
    
    func isAmountEmpty() -> Bool {
        if self.amount == nil {
            return true
        }
        else{
            return false
        }
    }
    
    func updateSpendingLimitByName(name: String, newLimit: Float){
        
        for spendingCategory in spendingCategories{
            if spendingCategory.category.name == name{
                spendingCategory.updateSpendingLimit(newLimit: newLimit)
            }
        }
    }
    
}
