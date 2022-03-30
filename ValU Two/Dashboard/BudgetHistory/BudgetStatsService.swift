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
        
        return Int(budget.amount)
        
    }
    
    func getEarnedAmount(budget: Budget) -> Int {
        var budgetTransactionsService = BudgetTransactionsService(budget: budget)
        let earnedTotal = budgetTransactionsService.getBudgetIncome() * -1
        return Int(earnedTotal)
    }
    
    func getAvailableString(budget: Budget) -> String {
        return CommonUtils.makeMoneyString(number: Int(budget.amount))
    }
    
    func getAmountBeat(budget: Budget) -> Int{
        return Int(budget.getAmountAvailable() - budget.spent)
    }
    
    
    
    
    func getBudgetStatusBarViewData(budget: Budget) -> [BudgetStatusBarViewData]{
        
        var viewDataToReturn = [BudgetStatusBarViewData]()
        let available = budget.getAmountAvailable()
        let total = budget.spent
        
        var allSectionsTotal = 0.0
        for section in budget.getBudgetSections(){
            let sectionTotal = section.spent
            allSectionsTotal = allSectionsTotal + sectionTotal
            let data = BudgetStatusBarViewData(percentage: sectionTotal / Double(total), color: colorMap[Int(section.colorCode)], name: section.name!, icon: section.icon!, action: nil, section: section)
            
            if sectionTotal > 0.0{
                viewDataToReturn.append(data)
            }
        }
        
        
        let otherTotal = Double(total) - allSectionsTotal
        if otherTotal > 0.0{
            let otherPercentage = Float(otherTotal) / total
            let otherData = BudgetStatusBarViewData(percentage: Double(otherPercentage), color: AppTheme().otherColor, name: "Other", icon: "book")
            viewDataToReturn.append(otherData)
        }
        
        viewDataToReturn.sort(by: { $0.percentage > $1.percentage })
        
        if available > total{
            let remainingPercentage = Float((total - Float(available)) / available)
            let remainingData = BudgetStatusBarViewData(percentage: Double(remainingPercentage), color: Color(#colorLiteral(red: 0.9543517232, green: 0.9543194175, blue: 0.9847152829, alpha: 1)), name: "Remaining", icon: "folder")
            viewDataToReturn.append(remainingData)
        }
        
        
        
        
        /*
        var viewDataToReturn = [BudgetStatusBarViewData]()
        let budgetTransactionsService = BudgetTransactionsService(budget: budget)
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
            sectionSpentTotal = spentInSection + sectionSpentTotal
            let data = BudgetStatusBarViewData(percentage: spentInSection / Double(total), color: colorMap[Int(section.colorCode)], name: section.name!, icon: section.icon!, action: nil, section: section)
            
            
            if spentInSection > 0.0{
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
            let remainingData = BudgetStatusBarViewData(percentage: Double(remainingPercentage), color: Color(#colorLiteral(red: 0.9543517232, green: 0.9543194175, blue: 0.9847152829, alpha: 1)), name: "Remaining", icon: "folder")
            viewDataToReturn.append(remainingData)
        }
        
        
        
        */
        
        return viewDataToReturn
        
        
        
        
    }
    
}
