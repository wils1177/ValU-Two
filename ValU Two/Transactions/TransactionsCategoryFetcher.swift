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
    
    static func getTransactionsForDateRange(startDate: Date, endDate: Date) -> [Transaction]{
        var toReturn = [Transaction]()
        do{
            toReturn = try DataManager().getTransactions(startDate: startDate, endDate: endDate)
        }
        catch{
            toReturn = [Transaction]()
        }
        
        return toReturn
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
