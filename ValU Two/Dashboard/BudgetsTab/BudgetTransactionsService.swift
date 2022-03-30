//
//  BudgetIncomeExpensesService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BudgetTransactionsService : ObservableObject {
    
    @Published var budget: Budget
    @Published var budgetTransactions : [Transaction]
    var lastMonthTransactions : [Transaction]
    
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
            
        do{
            let start = Calendar.current.date(byAdding: .month, value: -1, to: startDate!)!
            let end = startDate
            
            self.lastMonthTransactions = try DataManager().getTransactions(startDate: start, endDate: end!)
        }
        catch{
            self.lastMonthTransactions = [Transaction]()
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
    
    func getLastMonthExpenseTransactions() -> [Transaction]{
        var transactionsToReturn = [Transaction]()
        for transaction in self.lastMonthTransactions{
            if (transaction.amount > 0 && !transaction.isHidden){
                transactionsToReturn.append(transaction)
            }
        }
        return transactionsToReturn
    }
    
    func getLastMonthIncomeTransactions() -> [Transaction]{
        var transactionsToReturn = [Transaction]()
        for transaction in self.lastMonthTransactions{
            if (transaction.amount < 0 && !transaction.isHidden){
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
    
    func getOtherSpentTotal() -> Double{
        let otherTransactions = getOtherTransactionsInBudget()
        var total = 0.0
        for transaction in otherTransactions{
            if transaction.amount > 0.0 && !transaction.isHidden{
                total = total + transaction.amount
            }
        }
        return total
    }
    
    
    
    func getOtherTransactionsInBudget() -> [Transaction]{
        
        let transactionsForBudget = self.budgetTransactions
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
    
    func getTransactionsForDate(date: Date) -> [Transaction]{
        var transactions = [Transaction]()
        for transaction in self.budgetTransactions{
            if transaction.date == date{
                transactions.append(transaction)
            }
        }
        return transactions
    }
    
    func sumTransactionsForDate(date: Date) -> Float{
        var total = 0.0
        for transaction in self.budgetTransactions{
            if transaction.date == date{
                total = transaction.amount + total
            }
        }
        
        return Float(total * -1)
        
    }
    
    func checkIfCategoryIsBudgeted(budget: Budget, transaction: Transaction) -> Bool{
        
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
    
    func getThisMonthSpending() -> [Double]{
        
        let start = self.budget.startDate!
        let end = Date()
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: self.getExpenseTransactions())
        
    }
    
    func getLastMonthSpending() -> [Double]{
        let start = Calendar.current.date(byAdding: .month, value: -1, to: self.budget.startDate!)!
        let end = self.budget.startDate!
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: self.getLastMonthExpenseTransactions())
    }
    
    func getThisMonthIncome() -> [Double]{
        
        let start = self.budget.startDate!
        let end = Date()
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: self.getIncomeTransactions()).map { $0 * -1 }
        
    }
    
    func getLastMonthIncome() -> [Double]{
        
        let start = Calendar.current.date(byAdding: .month, value: -1, to: self.budget.startDate!)!
        let end = self.budget.startDate!
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: self.getLastMonthIncomeTransactions()).map { $0 * -1 }
        
    }
    
    func getGraphLabels() -> [Date]{
        let start =  self.budget.startDate!
        let end = self.budget.endDate!
        
        return ThisMonthLastMonthService.createLegendValues(start: start, end: end)
    }
    
    
    

    
    
    
    
    
    
}
