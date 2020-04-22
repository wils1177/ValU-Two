//
//  BudgetCopyer.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BudgetCopyer{
    
    
    func copyBudget(budget: Budget) -> Budget{
        
        let newBudget = budget.copy() as! Budget
        
        newBudget.spent = Float(0.0)
        newBudget.inflow = Float(0.0)
        
        for newCategory in newBudget.getAllSpendingCategories(){
            
            for category in budget.getAllSpendingCategories(){
                if newCategory.name! == category.name!{
                    newCategory.limit = category.limit
                    newCategory.selected = category.selected
                }
            }
            
            
            newCategory.spent = Float(0.0)
            newCategory.initialThirtyDaysSpent = Float(0.0)
        }
        
        newBudget.setTimeFrame(timeFrame: TimeFrame.monthly)
        
        DataManager().saveDatabase()
        return newBudget
    }
    
    func copyBudgetForNextPeriod(budget: Budget)->Budget{
        let newBudget = copyBudget(budget: budget)
        budget.active = false
        newBudget.active = true
        DataManager().saveDatabase()
        return newBudget
    }
    
    func copyBudgetForUpcomming(budget: Budget) -> Budget{
        let newBudget = copyBudget(budget: budget)
        budget.active = true
        newBudget.active = false
        newBudget.incrementTimeFrame()
        DataManager().saveDatabase()
        return newBudget
    }
    
    func checkIfBudgetIsOutdated(){
        
        let currentBudget = try? DataManager().getBudget()
        
        if currentBudget != nil{
            
            let currentDate = Date()
            let startDate = currentBudget!.startDate
            let endDate = currentBudget!.endDate
            
            if !(startDate! ... endDate!).contains(currentDate){
                
                self.copyBudgetForNextPeriod(budget: currentBudget!)
                
            }
            
        }
    }
    
    func checkIfUpcomingBudgetExists() -> Budget?{
        let futureQuery = PredicateBuilder().generateFutureBudgetPredicate(currentDate: Date())
        let futureBudgets = try! DataManager().getBudgets(predicate: futureQuery)
        
        let currentDate = Date()
        
        for budget in futureBudgets{
            let startDate = budget.startDate!
            let endDate = budget.endDate!
            
            if !(startDate ... endDate).contains(currentDate){
                
                return budget
                
            }
        }
        
        return nil
        
    }
    
    
    
    
}
