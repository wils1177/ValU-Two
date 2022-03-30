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
    var budgetTransactionsService : BudgetTransactionsService
    
    init(budgetTransactionsService: BudgetTransactionsService){
        self.budgetTransactionsService = budgetTransactionsService
        getTransactionsInOtherCategory()
    }
    
    
    func getTransactionsInOtherCategory(){
        self.unassignedTransactions = [Transaction]()
        self.unassignedTransactions = self.budgetTransactionsService.getOtherTransactionsInBudget()
    }
    
    
    
    
    
}
