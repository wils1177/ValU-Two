//
//  OtherBudgetViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/16/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import Foundation

class OtherBudgetViewModel {
    
    struct OtherBudgetSectionData: Hashable {
        var spendingCategory : SpendingCategory
        var transactions : [Transaction]
        var id = UUID()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    var categories = [BudgetCategory]()
    var categoriesData = [OtherBudgetSectionData]()
    var unassignedTransactions = [Transaction]()
    var budget: Budget
    
    init(budgetSections: [BudgetSection], budget: Budget){
        self.budget = budget
        self.categories = getUnbudgetedCategories(sections: budgetSections)
        getTransactionsInOtherCategory()
        createCategoriesData()
    }
    
    func getUnbudgetedCategories(sections: [BudgetSection]) -> [BudgetCategory]{
        var toReturn = [BudgetCategory]()
        
        for section in sections {
            if section.getLimit() == 0.0{
                for category in section.getBudgetCategories(){
                    toReturn.append(category)
                }
            }
        }
        
        return toReturn
    }
    
    func createCategoriesData() {
        
        var data = [OtherBudgetSectionData]()
        var categories = self.categories
        categories = categories.sorted(by: { $0.spendingCategory!.name! > $1.spendingCategory!.name! })
        
        for category in categories{
            //if category.limit > 0.0 {
            let transactions = getTransactionsForCategory(category: category.spendingCategory!)
            if transactions.count > 0 {
                let newData = OtherBudgetSectionData(spendingCategory: category.spendingCategory!, transactions: transactions)
                data.append(newData)
            }
                
            //}
            
        }
        
        let allSpendingCategories = SpendingCategoryService().getSubSpendingCategories()
        for spendingCategory in allSpendingCategories{
            if spendingCategory.budgetCategory == nil{
                let transactions = getTransactionsForCategory(category: spendingCategory)
                let newData = OtherBudgetSectionData(spendingCategory: spendingCategory, transactions: transactions)
                data.append(newData)
            }
        }
        
        self.categoriesData = data
        
    }
    
    func getTransactionsInOtherCategory(){
        self.unassignedTransactions = [Transaction]()
        self.unassignedTransactions =  TransactionsCategoryFetcher.fetchOtherTransactionsInBudget(budget: self.budget)
    }
    
    
    
    func getTransactionsForCategory(category: SpendingCategory) -> [Transaction]{
        
        let startDate = budget.startDate!
        let endDate = budget.endDate!
        
        return TransactionsCategoryFetcher.fetchTransactionsForCategoryAndDateRange(spendingCategory: category, startDate: startDate, endDate: endDate)
        
        
    }
    
}
