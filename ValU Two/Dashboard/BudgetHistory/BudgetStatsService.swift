//
//  BudgetStatsService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/23/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class BudgetStatsService{
    
    var budgets: [Budget]
    
    init(budgets: [Budget]){
        self.budgets = budgets
    }
    
    func getCompletedBudgets() -> Int{
        return budgets.count
    }
    
    func getSavingsGoalAmount(budget: Budget) -> Int{
        return Int(budget.amount - budget.getAmountAvailable())
    }
    
    
    func getTotalAmountSaved() -> Int{
        var total = 0
        for budget in self.budgets{
            total = total + getAmountSavedForBudget(budget: budget)
        }
        
        if total > 0 {
            return Int(total)
        }
        else{
            return 0
        }
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
        let spent = budget.spent
        let saved = Double(budget.amount) - Double(spent)
    
        return Int(saved)
    }
    
    func didHitSavingsGoal(budget: Budget) -> Bool{
        if budget.spent <= budget.getAmountAvailable(){
            return true
        }
        else{
            return false
        }
    }
    
    func didSaveAnything(budget: Budget) -> Bool{
        if budget.spent > budget.amount{
            return false
        }
        else{
            return true
        }
    }
    
    
    
    func getSpentAmount(budget: Budget) -> Int {
        
        return Int(budget.spent)
        
    }
    
    func getEarnedAmount(budget: Budget) -> Int {
        var budgetTransactionsService = BudgetTransactionsService(budget: budget)
        let earnedTotal = budgetTransactionsService.getBudgetIncome() * -1
        return Int(earnedTotal)
    }
    
    func getAvailableString(budget: Budget) -> String {
        return CommonUtils.makeMoneyString(number: Int(budget.getAmountAvailable()))
    }
    
    func getAmountBeat(budget: Budget) -> Int{
        return Int(budget.getAmountAvailable() - budget.spent)
    }
    

    
}
