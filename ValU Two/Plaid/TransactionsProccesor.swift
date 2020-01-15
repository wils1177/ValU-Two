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
    
    func updateInitialThiryDaysSpent(spendingCategories: [SpendingCategory]){
        
        let today = Date()
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: today)

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
        
        //Reset previous calculation on spending categoies
        for spendingCategory in spendingCategories{
            spendingCategory.amountSpent = 0.0
        }
        
        
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
        let matches = matchTransactionToSpendingCategory(transaction: transaction, spendingCategories: spendingCategories)
        
        var largestDepth = 0
        for match in matches{
            
            // We will update the amount for EVERY match
            match.amountSpent = match.amountSpent + Float(transaction.amount)
            
            // We will update the assigned category for the most specific category available
            let categoryArray = match.category!.contains ?? [String]()
            let categoryDepth = categoryArray.count
            if categoryDepth > largestDepth{
                transaction.category = match.category
                largestDepth = (match.category?.contains!.count)!
            }
            
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
        print("what the frick")
        //If we fail, the 'other' category will be the match
        if matches.count == 0{
            print("1")
            for spendingCateogory in spendingCategories{
                print("2")
                if spendingCateogory.category?.name == SpendingCategoryNames.other.rawValue{
                    print("is this being hit???")
                    matches.append(spendingCateogory)
                }
            }
        }
        
        return matches
        
    }
    
    
    
    
}
