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
        
        let time = PredicateBuilder().generateInDatesPredicate(startDate: startDate, endDate: endDate)
        let category = PredicateBuilder().generateTransactionsForCategoryIdPredicate(ids: [spendingCategory.id!])
        
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [time, category])
        
        var transactions = [Transaction]()
        do{
            transactions = try DataManager().getTransactions(predicate: compound)
        }
        catch{
            print("Could not fetch transactions for spending category & date")
    
        }
        
        
        return transactions
    }
    
    static func fetchTransactionsForBudgetSectionAndDateRange(section: BudgetSection, startDate: Date, endDate: Date) -> [Transaction]{
        var results = [Transaction]()
        for category in section.getBudgetCategories(){
            let categoryTransactions = TransactionsCategoryFetcher.fetchTransactionsForCategoryAndDateRange(spendingCategory: category.spendingCategory!, startDate: startDate, endDate: endDate)
            results.append(contentsOf: categoryTransactions)
        }
        return results
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
