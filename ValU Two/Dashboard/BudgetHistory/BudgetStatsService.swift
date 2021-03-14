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
        let budgetTransactionsService = BudgetTransactionsService(budget: budget)
        let spent = budgetTransactionsService.getBudgetExpenses()
        let saved = Double(budget.amount) - spent
    
        return Int(saved)
    }
    
    func didHitSavingsGoal(budget: Budget) -> Bool{
        let amountSaved = getAmountSavedForBudget(budget: budget)
        if amountSaved >= Int(budget.amount * budget.savingsPercent){
            return true
        }
        
        return false
    }
    
    func getSpentAmount(budget: Budget) -> Int {
        var budgetTransactionsService = BudgetTransactionsService(budget: budget)
        let spentTotal = budgetTransactionsService.getBudgetExpenses()
        return Int(spentTotal)
        
    }
    
    func getEarnedAmount(budget: Budget) -> Int {
        var budgetTransactionsService = BudgetTransactionsService(budget: budget)
        let earnedTotal = budgetTransactionsService.getBudgetIncome() * -1
        return Int(earnedTotal)
    }
    
    
    
    
    func getBudgetStatusBarViewData(budget: Budget) -> [BudgetStatusBarViewData]{
        
        var viewDataToReturn = [BudgetStatusBarViewData]()
        var budgetTransactionsService = BudgetTransactionsService(budget: budget)
        
        let amountAvailable = budget.getAmountAvailable()
        let spentTotal = budgetTransactionsService.getBudgetExpenses()
        let otherTotal = budgetTransactionsService.getOtherSpentTotal()
        var total = amountAvailable
        
        if spentTotal > Double(amountAvailable){
            total = Float(spentTotal)
        }
        
        
        var sectionSpentTotal = 0.0
        for section in budget.getBudgetSections(){
            let spentInSection = section.getSpent()
            let limitForSection = section.getLimit()
            sectionSpentTotal = spentInSection + sectionSpentTotal
            let data = BudgetStatusBarViewData(percentage: spentInSection / Double(total), color: colorMap[Int(section.colorCode)], name: section.name!, icon: section.icon!)
            
            if limitForSection > 0.0 && spentInSection > 0.0{
                viewDataToReturn.append(data)
            }
            
        }
        
        
        let otherPercentage = Float(otherTotal) / total
        let otherData = BudgetStatusBarViewData(percentage: Double(otherPercentage), color: AppTheme().otherColor, name: "Other", icon: "book")
        viewDataToReturn.append(otherData)
        
        viewDataToReturn.sort(by: { $0.percentage > $1.percentage })
        
        
        if !(spentTotal > Double(amountAvailable)){
            viewDataToReturn.sort(by: { $0.percentage > $1.percentage })
            let remainingPercentage = Float((total - Float(spentTotal)) / total)
            let remainingData = BudgetStatusBarViewData(percentage: Double(remainingPercentage), color: Color(.systemGreen), name: "Savings", icon: "dollarsign.circle")
            
            viewDataToReturn.insert(remainingData, at: 0)
        }
        
        
        
        return viewDataToReturn
    }
    
}
