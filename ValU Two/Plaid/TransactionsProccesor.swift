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
    var spendingCategories : [SpendingCategory]
    var transactionRules : [TransactionRule]
    
    init(spendingCategories: [SpendingCategory], transactionRules: [TransactionRule] = [TransactionRule]()){
        self.spendingCategories = spendingCategories
        self.transactionRules = transactionRules
    }
    
    func updateInitialThiryDaysSpent(){
        
        let today = Date()
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: today)
    
        
        for category in self.spendingCategories{
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
    
    
    func attemptToReplcePendingTransaction(pendingTransactionId: String, transactionData: TransactionJSON) -> Bool{
        do{
            //Find the transaction, and delete the categories first
            let transactionToReplace = try dataManager.getEntity(predicate: PredicateBuilder().generateTransactionIdPredicate(transactionId: pendingTransactionId), entityName: "Transaction") as! [Transaction]
            if transactionToReplace.count == 1 {
                let transaction = transactionToReplace[0]
                transaction.transactionId = transactionData.transactionId
                transaction.amount = transactionData.amount
                
                /*
                if transactionData.authDate != nil{
                    transaction.date = CommonUtils().getDate(dateString: transactionData.authDate!)
                }
                */ 
                
                transaction.name = transactionData.name
                transaction.merchantName = transactionData.merchantName
                transaction.pending = transactionData.pending
                dataManager.saveDatabase()
                print("Sucessfully replaced a pending transaction")
                return true
                
            }
            else{
                print("Not 1 exactly transaction came back for multuple transaction search")
                return false
            }
        }
        catch{
            print("Could not replace a pending transaction")
            return false
        }
    }
    
    
    func proccessTransactionToCategory(transaction: Transaction, spendingCategories: [SpendingCategory]){
        
        if transaction.transactionId != nil{
            
            // First, we will see if there any matches based on existign rules
            var spendingCategoryMatches = checkForRuleMatches(transaction: transaction, spendingCategories: spendingCategories)
            
            // If there are no matches from existing rules, match on default logic 
            if spendingCategoryMatches.count == 0{
                spendingCategoryMatches = matchTransactionToSpendingCategory(transaction: transaction, spendingCategories: spendingCategories)
            }
            
            //Check if the transaction should be auto-hidden
            if checkIfTransactionShouldBeHidden(transaction: transaction){
                transaction.isHidden = true
            }
            
            //Turn the spending category matches into category match objects
            let matches = createCategoryMatches(transaction: transaction, spendingCategories: spendingCategoryMatches)
            
            for match in matches{
                
                transaction.addToCategoryMatches(match)
                match.spendingCategory!.addToTransactions(transaction)
            }

            dataManager.saveDatabase()
        }
        
        
        
        
    }
    
    //Get's any matches from existing transaction rules
    func checkForRuleMatches(transaction: Transaction, spendingCategories: [SpendingCategory]) -> [SpendingCategory]{
        
        var matches = [SpendingCategory]()
        let nameToCompare = (transaction.merchantName ?? (transaction.name!)).lowercased()
        for rule in self.transactionRules{
            if nameToCompare.contains(rule.name!.lowercased()){
                
                for spendingCategory in spendingCategories{
                    
                    for ruleSpendingCategory in rule.spendingCategories?.allObjects as! [SpendingCategory]{
                        if ruleSpendingCategory.id == spendingCategory.id{
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
        var depth = Int32(2)
        if match != nil{
            for category in spendingCategories{
                if category.matchDepth < depth{
                    match = category
                    depth = category.matchDepth
                }
            }
            return [match!]
        }
        return [SpendingCategory]()
        
    }
    
    
    func checkIfTransactionShouldBeHidden(transaction: Transaction) -> Bool{
        
        if transaction.plaidCategories != nil {
            if transaction.plaidCategories!.contains("Internal Account Transfer"){
                return true
            }
            if transaction.plaidCategories!.contains("Payment") && transaction.plaidCategories!.contains("Credit Card"){
                return true
            }
        }
        
        return false
    }
    
    //Determines which categories match a transaction
    func matchTransactionToSpendingCategory(transaction: Transaction, spendingCategories: [SpendingCategory]) -> [SpendingCategory]{
        
        var matches = [SpendingCategory]()
        
        
        //Try to match the category and transaction labels
        for spendingCateogory in spendingCategories{
            let categoryLabels:Set<String> = Set(spendingCateogory.contains!)
            let transactionCategoryLabels:Set<String> = Set(transaction.plaidCategories!)
            
            
            if categoryLabels.contains(where: transactionCategoryLabels.contains){
                // We have a match!
                matches.append(spendingCateogory)
            }
            
            /*
            if categoryLabels.isSubset(of: transactionCategoryLabels){
                
                // We have a match!
                matches.append(spendingCateogory)
                
            }
            */
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
    
    func checkIfShouldBeHidden(transaction: Transaction){
        if transaction.plaidCategories != nil{
            if transaction.plaidCategories!.contains("Internal Account Transfer"){
                transaction.isHidden = true
            }
            else if transaction.plaidCategories!.contains("Credit Card"){
                transaction.isHidden = true
            }
        }
        
    }

    
}
