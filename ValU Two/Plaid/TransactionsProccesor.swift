//
//  TransactionsProccesor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/26/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

enum SpendingCategoryNames: String{
    case other = "Other"
}

class TransactionProccessor{
    let dataManager = DataManager()
    let budget : Budget
    
    init(budget: Budget){
        self.budget = budget
    }
    
    func updateInitialThiryDaysSpent(){
        
        let today = Date()
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: today)
        
        let spendingCategories = self.budget.getAllSpendingCategories()

        do{
            let transactions = try dataManager.getTransactions(startDate: thirtyDaysAgo!, endDate: today)
            //Search for matching spending category for transaction, and add spending to it
            for transaction in transactions{
                
                let matches = matchTransactionToSpendingCategory(transaction: transaction, spendingCategories: spendingCategories)
                for match in matches{
                    match.initialThirtyDaysSpent = match.initialThirtyDaysSpent + Float(transaction.amount)
                }
                
            }
            
        }
        catch{
            print("woops")
        }
        
        
        
    }
    
    
    func initilizeSpendingCategoryAmounts(spendingCategories: [SpendingCategory], startDate: Date, endDate: Date){
        
        do{
            let transactions = try dataManager.getTransactions(startDate: startDate, endDate: endDate)
            for transaction in transactions{
                proccessTransactionToCategory(transaction: transaction, spendingCategories: spendingCategories)
            }
        }
        catch{
            print("Could not pull those transactions")
        }
  
    }
    
    
    func proccessTransactionToCategory(transaction: Transaction, spendingCategories: [SpendingCategory]){
        
        if transaction.transactionId != nil && isWithinBudgetDates(transactionDate: transaction.date!){
            let matches = matchTransactionToSpendingCategory(transaction: transaction, spendingCategories: spendingCategories)
            
            for match in matches{
                
                // We will update the amount for EVERY match
                match.amountSpent = match.amountSpent + Float(transaction.amount)
                transaction.addToCategoryMatches(match.category!)
            }
                
            //ToDO: Filter to only add to budget that transaction is within the dates of the budget
            if transaction.amount > 0{
                self.budget.spent = self.budget.spent + (Float(transaction.amount))
            }
            
                 
            dataManager.saveDatabase()
        }
        
        
    }
    
    func matchTransactionToSpendingCategory(transaction: Transaction, spendingCategories: [SpendingCategory]) -> [SpendingCategory]{
        
        var matches = [SpendingCategory]()
        
        //Try to match the category and transaction labels
        for spendingCateogory in spendingCategories{
            let categoryLabels:Set<String> = Set(spendingCateogory.category!.contains!)
            let transactionCategoryLabels:Set<String> = Set(transaction.plaidCategories!)
            
            if categoryLabels.isSubset(of: transactionCategoryLabels){
                matches.append(spendingCateogory)
            }
            
        }
        
        
        
        return matches
        
    }
    
    func isWithinBudgetDates(transactionDate: Date) -> Bool{
        
        let startDate = self.budget.startDate!
        let endDate = self.budget.endDate!
        
        return (startDate ... endDate).contains(transactionDate)
        
    }
    

    
    
    
    
}
