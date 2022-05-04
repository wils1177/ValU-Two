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
    
    var recurringBudgetCategories: [BudgetCategory]
    
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
        
        self.recurringBudgetCategories = BudgetTransactionsService.getRecurringBudgetCategories(budget: budget)
        
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
    
    func getBudgetExpenses(includeRecurring: Bool = true) -> Double {
        
        
        var expenses = 0.0

        for transaction in self.budgetTransactions{
            if (transaction.amount > 0 && !transaction.isHidden){
                let matches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
                if matches.count == 0{
                    expenses = expenses + Double(transaction.amount)
                }
                else{
                    for categoryMatch in transaction.categoryMatches?.allObjects as! [CategoryMatch]{
                        if includeRecurring{
                            expenses = expenses + Double(categoryMatch.amount)
                        }
                        else{
                            var isRecurring = false
                            for category in recurringBudgetCategories {
                                if categoryMatch.spendingCategory!.id! == category.spendingCategory!.id!{
                                    isRecurring = true
                                }
                            }
                            if !isRecurring{
                                expenses = expenses + Double(categoryMatch.amount)
                            }
                        }
                        
                    }
                }
            }
        }
        return expenses
    }
    
    static func getRecurringBudgetCategories(budget: Budget) -> [BudgetCategory]{
        var recurringCategories = [BudgetCategory]()
        
        for section in budget.getBudgetSections(){
            for cat in section.getBudgetCategories(){
                if cat.recurring{
                    recurringCategories.append(cat)
                }
            }
        }
        return recurringCategories
    }
    
    //Get amount to spend
    //Get assumed spending
    //Get actual spending excluding any assumed spending
    //Minus above from value from amount to Spend
    func getLeftInBudget() -> Double{
        let availableToSpend = self.budget.getAmountAvailable()
        let assumedSpending = getAssumedSpending()
        let actualSpendingWithOutAssumed = self.getBudgetExpenses(includeRecurring: false)
        return (Double(availableToSpend)-assumedSpending) - actualSpendingWithOutAssumed
    }
    
    func getFreeLimit() -> Double{
        let availableToSpend = self.budget.getAmountAvailable()
        let assumedSpending = getAssumedSpending()
        return Double(availableToSpend) - assumedSpending
    }
    
    func getAssumedSpending() -> Double{
        var total = 0.0
        for section in self.budget.getBudgetSections(){
            let assumed = section.getRecurringLimit()
            total = total + assumed
        }
        return total
    }
    
    func getExpenseTransactions(includeRecurring : Bool = false) -> [Transaction]{
        var transactionsToReturn = [Transaction]()
        for transaction in self.budgetTransactions{
            if (transaction.amount > 0 && !transaction.isHidden){
                
                if !includeRecurring{
                    let isRecurring = checkIfTransactionIsRecurring(transaction: transaction)
                    if !isRecurring{
                        transactionsToReturn.append(transaction)
                    }
                }
                else{
                    transactionsToReturn.append(transaction)
                }
                
                
            }
        }
        return transactionsToReturn
    }
    
    func checkIfTransactionIsRecurring(transaction: Transaction) -> Bool{
        let matches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
        var anyRecurring = false
        for match in matches{
            for cat in self.recurringBudgetCategories{
                if match.spendingCategory!.id == cat.spendingCategory!.id{
                    anyRecurring = true
                }
            }
        }
        return anyRecurring
    }
    
    func getLastMonthExpenseTransactions(includeRecurring: Bool = true) -> [Transaction]{
        var transactionsToReturn = [Transaction]()
        for transaction in self.lastMonthTransactions{
            if (transaction.amount > 0 && !transaction.isHidden){
                
                if includeRecurring{
                    transactionsToReturn.append(transaction)
                }
                else{
                    if !checkIfTransactionIsRecurring(transaction: transaction){
                        transactionsToReturn.append(transaction)
                    }
                }
                
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
        
        let today = Date()
        
        var end = today
        if today > self.budget.endDate!{
            end = Calendar.current.date(byAdding: .day, value: -1, to: self.budget.endDate!)!
            
        }
        
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: self.getExpenseTransactions())
        
    }
    
    func getLastMonthSpending() -> [Double]{
        let start = Calendar.current.date(byAdding: .month, value: -1, to: self.budget.startDate!)!
        let end = self.budget.startDate!
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: self.getLastMonthExpenseTransactions(includeRecurring: false))
    }
    
    func getThisMonthIncome() -> [Double]{
        
        let start = self.budget.startDate!
        
        let today = Date()
        
        var end = today
        if today > self.budget.endDate!{
            end = Calendar.current.date(byAdding: .day, value: -1, to: self.budget.endDate!)!
            
        }
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: self.getIncomeTransactions()).map { $0 * -1 }
        
    }
    
    func getLastMonthIncome() -> [Double]{
        
        let start = Calendar.current.date(byAdding: .month, value: -1, to: self.budget.startDate!)!
        let end = self.budget.startDate!
        
        return ThisMonthLastMonthService.createDataPoints(start: start, end: end, transactions: self.getLastMonthIncomeTransactions()).map { $0 * -1 }
        
    }
    
    
    func getTransactionsForBudgetSection(section: BudgetSection){
        
    }
    
    
    func getGraphLabels() -> [Date]{
        let start =  self.budget.startDate!
        let end = self.budget.endDate!
        
        return ThisMonthLastMonthService.createLegendValues(start: start, end: end)
    }
    
    
    
    
    
    

    
    
    
    
    
    
}
