//
//  BudgetStatsService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/23/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BudgetStatsService{
    
    var budgets: [Budget]
    
    init(budgets: [Budget]){
        self.budgets = budgets
    }
    
    func getCompletedBudgets() -> Int{
        return budgets.count
    }
    
    func getTotalAmountSaved() -> Int{
        var total = 0
        for budget in self.budgets{
            total = total + getAmountSavedForBudget(budget: budget)
        }
        return total
    }
    
    func getSavingsGoalsHit() -> Int{
        var total = 0
        for budget in self.budgets{
            let amountSaved = getAmountSavedForBudget(budget: budget)
            if amountSaved >= Int(budget.amount * budget.savingsPercent){
                total = total + 1
            }
        }
        return total
    }
    
    func getSavingsGoalsMissed() -> Int{
        var total = 0
        for budget in self.budgets{
            let amountSaved = getAmountSavedForBudget(budget: budget)
            if amountSaved < Int(budget.amount * budget.savingsPercent){
                total = total + 1
            }
        }
        return total
    }
    
    func getAmountSavedForBudget(budget: Budget) -> Int{
        let saved = budget.amount - budget.spent
        
        if saved > 0 {
            return Int(saved)
        }
        else{
            return 0
        }
 
    }
    
    func didHitSavingsGoal(budget: Budget) -> Bool{
        let amountSaved = getAmountSavedForBudget(budget: budget)
        if amountSaved >= Int(budget.amount * budget.savingsPercent){
            return true
        }
        
        return false
    }
    
}
