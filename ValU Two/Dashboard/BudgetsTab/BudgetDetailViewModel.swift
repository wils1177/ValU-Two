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


struct BudgetDetailViewModel {

    
    func getTransactionsForCategory(category: BudgetCategory) -> [Transaction]{
        
        let budget = category.budgetSection!.budget!
        let startDate = budget.startDate!
        let endDate = budget.endDate!
        
        let spendingCategory = category.spendingCategory!
        
        return TransactionsCategoryFetcher.fetchTransactionsForCategoryAndDateRange(spendingCategory: spendingCategory, startDate: startDate, endDate: endDate)
        
        
    }
    
}
