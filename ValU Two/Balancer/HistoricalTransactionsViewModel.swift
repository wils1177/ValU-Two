//
//  HistoricalTransactionsViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/23/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class HistoricalTransactionsViewModel{
    
    var budgetCategory: BudgetCategory
    var transactions = [Transaction]()
    
    
    init(category: BudgetCategory){
        self.budgetCategory = category
        self.transactions = getListOfTransactions()
    }
    
    func getDisplayText() -> String {
        let timeFrame = self.budgetCategory.budgetSection?.budget?.timeFrame
        if timeFrame == 0{
            return CommonUtils.makeMoneyString(number: Int(getPreviouslySpent())) + " spent in the last 30 days"
        }
        else if timeFrame == 1{
            return CommonUtils.makeMoneyString(number: Int(getPreviouslySpent())) + " spent in the last 15 days"
        }
        else{
            return CommonUtils.makeMoneyString(number: Int(getPreviouslySpent())) + " spent in the last week"
        }
    }
    
    func getListOfTransactions() -> [Transaction]{
        
        let timeFrame = self.budgetCategory.budgetSection!.budget!.timeFrame
        let endDate = Date()
        var startDate = Date()
        
        if timeFrame == 0{
            startDate = Calendar.current.date(byAdding: .day, value: -30, to: endDate)!
        }
        else if timeFrame == 1{
            startDate = Calendar.current.date(byAdding: .day, value: -15, to: endDate)!
        }
        else{
            startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!
        }
        
        return TransactionsCategoryFetcher.fetchTransactionsForCategoryAndDateRange(spendingCategory: budgetCategory.spendingCategory!, startDate: startDate, endDate: endDate)
        
    }
    
    func getPreviouslySpent() -> Double {
        
        var total = 0.0
        for transaction in self.transactions{
            if transaction.amount > 0 {
                total = transaction.amount + total
            }
        }
        
        return total
        
    }
    
}
