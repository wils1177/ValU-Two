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
    
    var rememberTransactionRule: Bool = true
    
    init(timeFrame: Int32){
        self.timeFrame = timeFrame
        self.transactions = getListOfTransactions()
    }
    
    func getSuffixText(bugetCategory: BudgetCategory) -> String {
        if self.timeFrame == 0{
            return " Spent in the last 30 days"
        }
        else if self.timeFrame == 1{
            return " Spent in the last 15 days"
        }
        else{
            return " Spent in the last week"
        }
    }
    
    func getDisplayTextForCategory(budgetCategory: BudgetCategory) -> String {
        let spent = self.getCategoryTotalText(budgetCategory: budgetCategory)
        let suffix = self.getSuffixText(bugetCategory: budgetCategory)
        
        return spent + suffix
    }
    
    func getCategoryTotalText(budgetCategory: BudgetCategory) -> String{
        return CommonUtils.makeMoneyString(number: Int(getPreviouslySpentInCategory(budgetCategory: budgetCategory)))
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
    
    func getMerchantTotals(budgetCategory: BudgetCategory) -> [MerchantTotals]{
        let transactions = self.getTransactionsForCategory(budgetCategory: budgetCategory)
        
        return BudgetTransactionsService.createMerchantTotals(transactions: transactions)
        
    }
    
    func getMerchantTotals() -> [MerchantTotals]{
        
        
        return BudgetTransactionsService.createMerchantTotals(transactions: self.transactions)
        
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
    
    func getIconsForMerchant(merchantTotal: MerchantTotals) -> [String]{
        let service = TransactionService()
        let transaction = merchantTotal.transactions[0]
        let matches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
        return service.getIcons(categories: matches)
    }
    
    func getCategoryNameForMerchant(merchantTotal: MerchantTotals) -> String{
        //let service = TransactionService()
        let transaction = merchantTotal.transactions[0]
        let matches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
        if matches.count > 0{
            return matches[0].spendingCategory!.name!
        }
        else{
            return "No Category"
        }
        
    }
    
    
    func migrateMerchantToCategory(merchantTotal: MerchantTotals, category: BudgetCategory){
        
        
        
        for transaction in merchantTotal.transactions{
            addTransactionToCategory(transaction: transaction, budgetCategory: category)
        }
        createTransactionRuleForMerchant(merchantTotal: merchantTotal, category: category)
        DataManager().saveDatabase()
        self.transactions = getListOfTransactions()
        self.objectWillChange.send()
        
    }
    
    func removeMerchantFromCategory(merchantToatl: MerchantTotals){
        let transactions = merchantToatl.transactions
        
        for transaction in transactions{
            self.removeTransactionCategories(transaction: transaction)
        }
        
        deleteTransactionRuleForMerchant(merchantTotal: merchantToatl)
        DataManager().saveDatabase()
    }
    
    func deleteTransactionRuleForMerchant(merchantTotal: MerchantTotals){
        let name = merchantTotal.name
        let predicate = PredicateBuilder().generateRuleByNamePredicate(name: name)
        let data = DataManager()
        do{
            
            try data.deleteEntity(predicate: predicate, entityName: "TransactionRule")
        }
        catch{
            print("Could not find a rule to delete!")
        }
        
    }
    
    func createTransactionRuleForMerchant(merchantTotal: MerchantTotals, category: BudgetCategory){
        
        let name = merchantTotal.name
        let spendingCategory = category.spendingCategory!
        
        do{
            //Check for existing rule
            let rule = try DataManager().getTransactionRules(name: name)
            if rule != nil{
                rule!.name = name
                //rule!.categories = categories
                //let currentCategories = NSSet(object: rule!.spendingCategories?.allObjects as! [SpendingCategory])
                rule!.spendingCategories = nil
                rule!.addToSpendingCategories(spendingCategory)
            }
            //If there is no existing rule, just make a new one
            else{
                let newRule = DataManager().saveTransactionRule(name: name, amountOverride: Float(0.0), categoryOverride: [String]())
                newRule.addToSpendingCategories(spendingCategory)
            }
            
        }
        catch{
            print("Could not create transaction rule!!")
        }
        
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
        //spendingCategory.addToTransactions(transaction)
        
        
    }
    
    func removeTransactionCategories(transaction: Transaction){
        
        for match in transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            
                let predicate = PredicateBuilder().generateByIdPredicate(id: match.id!)
                
                do{
                    
                    try DataManager().deleteEntity(predicate: predicate, entityName: "CategoryMatch")
                    print("removed!")
                    
                    //DataManager().saveDatabase()
                    //self.objectWillChange.send()
                    //transaction.objectWillChange.send()
                }
                catch{
                    print("Could not remove the category match!!")
                }
            
        }
        
    }
    

    
}
