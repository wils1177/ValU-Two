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


class BudgetDetailViewModel {
    
    var categories = [BudgetDetailCatgeryViewData]()
    var section : BudgetSection
    
    init(budgetSection: BudgetSection){
        self.section = budgetSection
        self.categories = createCategoryData()
    }
    
    func createCategoryData() -> [BudgetDetailCatgeryViewData]{
        
        var data = [BudgetDetailCatgeryViewData]()
        let categories = self.section.budgetCategories?.allObjects as! [BudgetCategory]
        
        for category in categories{
            //if category.limit > 0.0 {
                let transactions = getTransactionsForCategory(category: category)
                let newData = BudgetDetailCatgeryViewData(category: category, transactions: transactions)
                data.append(newData)
            //}
            
        }
        
        return data
        
    }
    
    func getTransactionsForCategory(category: BudgetCategory) -> [Transaction]{
        
        let budget = category.budgetSection!.budget!
        let startDate = budget.startDate!
        let endDate = budget.endDate!
        
        let spendingCategory = category.spendingCategory!
        
        return TransactionsCategoryFetcher.fetchTransactionsForCategoryAndDateRange(spendingCategory: spendingCategory, startDate: startDate, endDate: endDate)
        
        
    }
    
}
