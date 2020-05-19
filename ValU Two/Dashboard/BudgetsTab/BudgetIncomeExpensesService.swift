//
//  BudgetIncomeExpensesService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BudgetIncomeExpensesService : ObservableObject {
    
    @Published var budget: Budget
    @Published var budgetTransactions : [Transaction]
    
    init(budget: Budget){
        self.budget = budget
        
        let startDate = budget.startDate
        let endDate = budget.endDate
            
        do{
            self.budgetTransactions = try DataManager().getTransactions(startDate: startDate!, endDate: endDate!)
        }
        catch{
            self.budgetTransactions = [Transaction]()
        }
            
            
        
    }
    
    func getBudgetIncome() -> Double {
        var income = 0.0
        for transaction in self.budgetTransactions{
            if (transaction.amount < 0 && !transaction.isHidden){
                let matches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
                if matches.count == 0{
                    income = income + Double(transaction.amount)
                }
                else{
                    for categoryMatch in transaction.categoryMatches?.allObjects as! [CategoryMatch]{
                        income = income + Double(categoryMatch.amount)
                    }
                }

            }
        }
        return income
    }
    
    func getBudgetExpenses() -> Double {
        var expenses = 0.0
        for transaction in self.budgetTransactions{
            if (transaction.amount > 0 && !transaction.isHidden){
                let matches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
                if matches.count == 0{
                    expenses = expenses + Double(transaction.amount)
                }
                else{
                    for categoryMatch in transaction.categoryMatches?.allObjects as! [CategoryMatch]{
                        expenses = expenses + Double(categoryMatch.amount)
                    }
                }
            }
        }
        return expenses
    }
    
    func getExpenseTransactions() -> [Transaction]{
        var transactionsToReturn = [Transaction]()
        for transaction in self.budgetTransactions{
            if (transaction.amount > 0 && !transaction.isHidden){
                transactionsToReturn.append(transaction)
            }
        }
        return transactionsToReturn
    }
    
    func getIncomeTransactions() -> [Transaction]{
        var transactionsToReturn = [Transaction]()
        for transaction in self.budgetTransactions{
            if (transaction.amount < 0 && !transaction.isHidden){
                transactionsToReturn.append(transaction)
            }
        }
        return transactionsToReturn
    }
    
}
