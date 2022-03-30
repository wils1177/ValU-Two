//
//  HistoricalTransactionsViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/23/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class HistoricalTransactionsViewModel: ObservableObject{
    
    @Published var transactions = [Transaction]()
    var timeFrame : Int32
    
    init(timeFrame: Int32){
        self.timeFrame = timeFrame
        self.transactions = getListOfTransactions()
    }
    
    func getSuffixText(bugetCategory: BudgetCategory) -> String {
        if self.timeFrame == 0{
            return " spent in the last 30 days"
        }
        else if self.timeFrame == 1{
            return " spent in the last 15 days"
        }
        else{
            return " spent in the last week"
        }
    }
    
    func getDisplayTextForCategory(budgetCategory: BudgetCategory) -> String {
        let spent = CommonUtils.makeMoneyString(number: Int(getPreviouslySpentInCategory(budgetCategory: budgetCategory)))
        let suffix = self.getSuffixText(bugetCategory: budgetCategory)
        
        return spent + suffix
    }
    
    func getListOfTransactions() -> [Transaction]{
        
        let endDate = Date()
        var startDate = Date()
        
        if self.timeFrame == 0{
            startDate = Calendar.current.date(byAdding: .day, value: -30, to: endDate)!
        }
        else if self.timeFrame == 1{
            startDate = Calendar.current.date(byAdding: .day, value: -15, to: endDate)!
        }
        else{
            startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!
        }
        
        return TransactionsCategoryFetcher.getTransactionsForDateRange(startDate: startDate, endDate: endDate)
        
    }
    
    func getTransactionsForCategory(budgetCategory: BudgetCategory) -> [Transaction]{
        
    
        
        var transactions = [Transaction]()
        for transaction in self.transactions{
            for categoryMatch in transaction.categoryMatches!.allObjects as! [CategoryMatch]{
                if categoryMatch.spendingCategory!.id == budgetCategory.spendingCategory!.id{
                    transactions.append(transaction)
                    break
                }
            }
        }
        return transactions
    }
    
    func isTransactionInCategory(transaction: Transaction, budgetCategory: BudgetCategory) -> Bool{
        for categoryMatch in transaction.categoryMatches!.allObjects as! [CategoryMatch]{
            if categoryMatch.spendingCategory!.id == budgetCategory.spendingCategory!.id{
                return true
            }
            
        }
        return false
    }
    
    func getPreviouslySpentInCategory(budgetCategory: BudgetCategory) -> Double{
        
        if budgetCategory.budgetSection == nil{
            return 0.0
        }
        
        var total = 0.0
        for transaction in self.transactions{
            for categoryMatch in transaction.categoryMatches!.allObjects as! [CategoryMatch]{
                if categoryMatch.spendingCategory!.id == budgetCategory.spendingCategory!.id{
                    total = total + transaction.amount
                    break
                }
            }
        }
        return total
    }
    
    
    
    func addTransactionToCategory(transaction: Transaction, budgetCategory: BudgetCategory){
        
        for match in transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            
                let predicate = PredicateBuilder().generateByIdPredicate(id: match.id!)
                
                do{
                    
                    try DataManager().deleteEntity(predicate: predicate, entityName: "CategoryMatch")
                    print("removed!")
                    
                }
                catch{
                    print("Could not remove the category match!!")
                }

        }
        
        let spendingCategory = budgetCategory.spendingCategory!
        let amount = transaction.amount
        
        _ = DataManager().createCategoryMatch(transaction: transaction, category: spendingCategory, amount: Float(amount))
        spendingCategory.addToTransactions(transaction)
        
        DataManager().saveDatabase()
        self.transactions = getListOfTransactions()
        self.objectWillChange.send()
    }
    

    
}
