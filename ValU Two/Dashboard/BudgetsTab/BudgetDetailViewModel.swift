//
//  BudgetDetailViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

struct BudgetDetailCatgeryViewData: Hashable{
    var category : BudgetCategory
    var transactions = [Transaction]()
    var id = UUID()
}

struct MerchantTotals : Hashable{
    var transactions : [Transaction]
    var name : String
    var amount = 0.0
    var id = UUID()
}


struct BudgetDetailViewModel {

    
    func getTransactionsForCategory(category: BudgetCategory) -> [Transaction]{
        
        let budget = category.budgetSection!.budget!
        let startDate = budget.startDate!
        let endDate = budget.endDate!
        
        let spendingCategory = category.spendingCategory!
        
        return TransactionsCategoryFetcher.fetchTransactionsForCategoryAndDateRange(spendingCategory: spendingCategory, startDate: startDate, endDate: endDate)
        
        
    }
    
    func getTransactionsForCategory(category: BudgetCategory, start: Date, end: Date) -> [Transaction]{
        
        
        let spendingCategory = category.spendingCategory!
        
        return TransactionsCategoryFetcher.fetchTransactionsForCategoryAndDateRange(spendingCategory: spendingCategory, startDate: start, endDate: end)
        
        
    }
    
    func getMerchangeTotalsForCategory(category: BudgetCategory) -> [MerchantTotals]{
        
        let transactions = getTransactionsForCategory(category: category)
        
        return BudgetTransactionsService.createMerchantTotals(transactions: transactions)
        
    }
    
    func getThisMonthTransactionsForSection(section: BudgetSection) -> [BalanceHistoryTotal]{
        let budget = section.budget!
        
        
        let start = budget.startDate!
        
        let today = Date()
        
        var end = today
        if today > budget.endDate!{
            end = budget.endDate!
        }
        
        let transactions = TransactionsCategoryFetcher.fetchTransactionsForBudgetSectionAndDateRange(section: section, startDate: start, endDate: end).filter { $0.isHidden == false }
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: transactions)
        
        
        
    }
    
    func getThisMonthTransactionsForCategory(category: BudgetCategory) -> [BalanceHistoryTotal]{
        let budget = category.budgetSection!.budget!
        
        let start = budget.startDate!
        
        let today = Date()
        
        var end = today
        if today > budget.endDate!{
            end = budget.endDate!
        }
        
        let transactions = self.getTransactionsForCategory(category: category, start: start, end: end).filter { $0.isHidden == false }
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: transactions)
        
        
        
    }
    
    func getLastMonthTransactionsForCategory(category: BudgetCategory) -> [BalanceHistoryTotal]{
        let budget = category.budgetSection!.budget!
        
        let start = Calendar.current.date(byAdding: .month, value: -1, to: budget.startDate!)!
        let end = budget.startDate!
        
        let transactions = self.getTransactionsForCategory(category: category, start: start, end: end).filter { $0.isHidden == false }
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: transactions)
        
        
        
    }
    
    func getLastMonthTransactionsForSection(section: BudgetSection) -> [BalanceHistoryTotal]{
        let budget = section.budget!
        let start = Calendar.current.date(byAdding: .month, value: -1, to: budget.startDate!)!
        let end = budget.startDate!
        
        let transactions = TransactionsCategoryFetcher.fetchTransactionsForBudgetSectionAndDateRange(section: section, startDate: start, endDate: end).filter { $0.isHidden == false }
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: transactions)
    }
    
    func getGraphLabels(section: BudgetSection) -> [Date]{
        let budget = section.budget!
        let start =  budget.startDate!
        let end = budget.endDate!
        
        return ThisMonthLastMonthService.createLegendValues(start: start, end: end)
    }
    
    func getGraphLabels(category: BudgetCategory) -> [Date]{
        let budget = category.budgetSection!.budget!
        let start =  budget.startDate!
        let end = budget.endDate!
        
        return ThisMonthLastMonthService.createLegendValues(start: start, end: end)
    }
    
}
