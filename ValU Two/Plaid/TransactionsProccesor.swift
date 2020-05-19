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

class TransactionProccessor: BudgetDateFindable{    
    
    let dataManager = DataManager()
    var budget : Budget
    var transactionRules : [TransactionRule]
    
    init(budget: Budget, transactionRules: [TransactionRule] = [TransactionRule]()){
        self.budget = budget
        self.transactionRules = transactionRules
    }
    
    func updateInitialThiryDaysSpent(){
        
        let today = Date()
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: today)
        
        let spendingCategories = self.budget.getAllSpendingCategories()
        
        for category in spendingCategories{
            category.initialThirtyDaysSpent = 0.0
        }

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
    
    
    func proccessTransactionToCategory(transaction: Transaction, spendingCategories: [SpendingCategory]){
        
        if transaction.transactionId != nil{
            
            //First match the amount to the time frame
            matchToTimeFrame(transaction: transaction)
            
            // First, we will see if there any matches based on existign rules
            var spendingCategoryMatches = checkForRuleMatches(transaction: transaction, spendingCategories: spendingCategories)
            //var matches = [CategoryMatch]()
            
            // If there are no matches from existing rules, match on default logic 
            if spendingCategoryMatches.count == 0{

                spendingCategoryMatches = matchTransactionToSpendingCategory(transaction: transaction, spendingCategories: spendingCategories)
            }
            
            //Turn the spending category matches into category match objects
            let matches = createCategoryMatches(transaction: transaction, spendingCategories: spendingCategoryMatches)
            
            for match in matches{
                
                // We will update the amount for EVERY match that's within the budget
                if CommonUtils.isWithinBudget(transaction: transaction, budget: match.spendingCategory!.budget!){
                    
                    match.spendingCategory!.spent = match.spendingCategory!.spent + match.amount
                    
                }
                
                transaction.addToCategoryMatches(match)
                match.spendingCategory!.addToTransactions(transaction)
            }
            
            if CommonUtils.isWithinBudget(transaction: transaction, budget: self.budget){
                self.budget.addToTransactions(transaction)
            }
            
                 
            dataManager.saveDatabase()
        }
        
        
        
        
    }
    
    //Get's any matches from existing transaction rules
    func checkForRuleMatches(transaction: Transaction, spendingCategories: [SpendingCategory]) -> [SpendingCategory]{
        
        var matches = [SpendingCategory]()
        for rule in self.transactionRules{
            if rule.name == transaction.name!{
                
                for spendingCategory in spendingCategories{
                    for ruleCategory in rule.categories!{
                        if spendingCategory.name == ruleCategory{
                            matches.append(spendingCategory)
                        }
                    }
                }
                
            }
        }
        return matches
        
        
    }
    
    // Gets the most specific category match in the set
    func getDeepestMatch(spendingCategories: [SpendingCategory]) -> [SpendingCategory]{
                
        var match = spendingCategories.first
        var depth = 0
        if match != nil{
            for category in spendingCategories{
                if category.contains!.count > depth{
                    match = category
                    depth = category.contains!.count
                }
            }
            return [match!]
        }
        return [SpendingCategory]()
        
    }
    
    
    
    //Determines which categories match a transaction
    func matchTransactionToSpendingCategory(transaction: Transaction, spendingCategories: [SpendingCategory]) -> [SpendingCategory]{
        
        var matches = [SpendingCategory]()
        
        
        //Try to match the category and transaction labels
        for spendingCateogory in spendingCategories{
            let categoryLabels:Set<String> = Set(spendingCateogory.contains!)
            let transactionCategoryLabels:Set<String> = Set(transaction.plaidCategories!)
            
            if categoryLabels.isSubset(of: transactionCategoryLabels){
                
                // We have a match!
                matches.append(spendingCateogory)
                
            }
            
        }
        
        
        let mostSpecifcMatches = getDeepestMatch(spendingCategories: matches)
        return mostSpecifcMatches
        
    }
    
    
    func createCategoryMatches(transaction: Transaction, spendingCategories: [SpendingCategory]) -> [CategoryMatch]{
        var matches = [CategoryMatch]()
        
        var count = 0
        for spendingCategory in spendingCategories{
            if count == 0{
                let categoryMatch = dataManager.createCategoryMatch(transaction: transaction, category: spendingCategory, amount: Float(transaction.amount))
                matches.append(categoryMatch)
            }
            else{
                let categoryMatch = dataManager.createCategoryMatch(transaction: transaction, category: spendingCategory, amount: Float(0.0))
                matches.append(categoryMatch)
            }
            
            
            count = count + 1
        }
        
        return matches
    }
    
    func matchToTimeFrame(transaction: Transaction){
        
        let types = [TimeFrame.monthly.rawValue, TimeFrame.weekly.rawValue, TimeFrame.semiMonthly.rawValue]

        do{
            let query = PredicateBuilder().generateInBetweenDatesPredicate(executionDate: transaction.date!)
            let timeFrames = try DataManager().getEntity(predicate: query, entityName: "TransactionDateCache") as! [TransactionDateCache]
            
            for type in types{
                
                var match : TransactionDateCache?
                
                //Check for a week level match
                //var isMatch = false
                for timeFrame in timeFrames{
                    print("MATCH FOUND")
                    if timeFrame.timeFrame == type{
                        //isMatch = true
                        match = timeFrame
                    }
                }
                
                //Now Update the match
                if match != nil{
                    match!.addToTransactions(transaction)
                    if transaction.amount > 0{
                        match!.expenses = match!.expenses + Float(transaction.amount)
                    }else{
                        match!.income = match!.income + Float(transaction.amount)
                    }
                }
                
            }
            
            
            
            
            
            /*
            //If there is no existing match, create a new one
            if !isMatch{
                print("creating a new entry due to the following date:")
                print(transaction.date!)
                print("new entry is: ")
                print(transaction.date!.startOfWeek!)
                print("end date would be")
                print(transaction.date!.endOfWeek!)
                print("the results count was")
                print(timeFrames.count)
                let dateCache = DataManager().createTransactionDateCache(dateFrom: transaction.date!, timeFrame: TimeFrame.weekly.rawValue)
                match = dateCache

            }
            */
            
            
            
            
            
            DataManager().saveDatabase()
            
            
        }
        catch{
            print("coult not fetch transaction time frames")
            
        }
        
        
        
        
    }
    
    
    

    
    
    
    
}
