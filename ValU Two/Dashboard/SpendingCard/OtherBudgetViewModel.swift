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

    var budgetTransactionsService : BudgetTransactionsService
    
    init(budgetTransactionsService: BudgetTransactionsService){
        self.budgetTransactionsService = budgetTransactionsService
    }
    
    
    
    func getOtherSpentTotal() -> Double{
        return self.budgetTransactionsService.getOtherSpentTotal()
    }
    
    func getleft() -> Double{
        let limitTotal  = self.budgetTransactionsService.budget.getSectionLimitTotal()
        
        let budgetToatl = self.budgetTransactionsService.budget.getAmountAvailable()
        
        let otherAvailable = Double(budgetToatl) - limitTotal
        
        return otherAvailable - getOtherSpentTotal()
    }
    
    func getPercentageSpent() -> Double{
        let limitTotal  = self.budgetTransactionsService.budget.getSectionLimitTotal()
        
        let budgetToatl = self.budgetTransactionsService.budget.getAmountAvailable()
        
        let otherAvailable = Double(budgetToatl) - limitTotal
        
        return getOtherSpentTotal() / otherAvailable
    }
    
    
    
    
    
    
    
}
