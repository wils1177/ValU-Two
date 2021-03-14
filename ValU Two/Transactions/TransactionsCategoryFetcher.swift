//
//  TransactionsCategoryFetcher.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

struct TransactionsCategoryFetcher{
    
    static func fetchTransactionsForCategoryAndDateRange(spendingCategory: SpendingCategory, startDate: Date, endDate: Date) -> [Transaction]{
        let allTransactions = spendingCategory.transactions?.allObjects as! [Transaction]
        var matchingTransactions = [Transaction]()
        
        for transaction in allTransactions{
            if CommonUtils.isWithinDates(transaction: transaction, start: startDate, end: endDate){
                matchingTransactions.append(transaction)
            }
        }
        return matchingTransactions
    }
    
    static func fetchOtherTransactionsInBudget(budget: Budget) -> [Transaction]{
        
        let transactionsForBudget = self.getAllTransactionsForBudget(budget: budget)
        var otherTransactions = [Transaction]()
        
        for transaction in transactionsForBudget{
            if transaction.categoryMatches?.allObjects.count == 0{
                otherTransactions.append(transaction)
            }
            else if !checkIfCategoryIsBudgeted(budget: budget, transaction: transaction){
                otherTransactions.append(transaction)
            }
        }
        return otherTransactions
        
    }
    
    static func checkIfCategoryIsBudgeted(budget: Budget, transaction: Transaction) -> Bool{
        
        let allCategoryMatches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
        
        for match in allCategoryMatches{
            let name = match.spendingCategory!.name!
            for budgetCategory in budget.getBudgetCategories(){
                if budgetCategory.spendingCategory!.name! == name{
                    return true
                }
            }
        }
        
        return false
    }
    
    static func getAllTransactionsForBudget(budget: Budget) -> [Transaction]{
        
        let predicate = PredicateBuilder().generateInDatesPredicate(startDate: budget.startDate!, endDate: budget.endDate!)
        var transactions = [Transaction]()
        
        do{
            transactions = try DataManager().getTransactions(predicate: predicate)
        }
        catch{
            print("COULD NOT COLLECT TRANSACTIONS FOR BUDGET")
            transactions = [Transaction]()
        }
        
        return transactions
    }
    
}
