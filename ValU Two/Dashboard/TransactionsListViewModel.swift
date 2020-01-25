//
//  TransactionsListViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

struct TransactionViewData: Hashable {
    var name : String = ""
    var amount : String = ""
    var category : String = ""
    var date : String = ""
    var icon : String = "🍩"
    var rawTransaction: Transaction
    
}

class TransactionsListViewModel{
    
    var transactions = [Transaction]()
    let dataManager = DataManager()
    var viewData = [TransactionViewData]()
    var budget : Budget?
    
    init(){
        //ToDo: Try-Catch this
        self.budget = try? dataManager.getBudget()
        fetchTransactionsForBudget()
        generateViewData()
    }
    
    init(categoryName: String){
        self.budget = try? dataManager.getBudget()
        fetchTransactions(categoryName: categoryName)
        generateViewData()
    }
    
    func fetchTransactions(categoryName: String){
        
        for spendingCategory in self.budget!.getSubSpendingCategories(){
            if spendingCategory.category!.name == categoryName{
                self.transactions = spendingCategory.category!.transactions?.allObjects as! [Transaction]
            }
        }
        
    }
    
    func generateViewData(){
        for transaction in self.transactions{
            let name = transaction.name
            let amount = String(format: "$%.02f", transaction.amount)
            let categoryMatches = transaction.categoryMatches!.allObjects as! [Category]
            let categoryMatch = getDeepestCategoryMatch(categories: categoryMatches)
            let category = categoryMatch?.name ?? "Other"
            let executionDate = transaction.date!
            let icon = categoryMatch?.icon ?? "❓"
            let df = DateFormatter()
            df.dateFormat = "MM-dd"
            let presentationDate = df.string(from: executionDate)
            let viewData = TransactionViewData(name: name ?? "No Name Available", amount: amount, category: category, date: presentationDate, icon: icon, rawTransaction: transaction)
            self.viewData.append(viewData)
        }
    }
    
    func fetchTransactionsForBudget(){
        
        if budget != nil{
            let startDate = self.budget?.startDate
            let endDate = self.budget?.endDate
            
            do{
                self.transactions = try dataManager.getTransactions(startDate: startDate!, endDate: endDate!)
            }
            catch{
                self.transactions = [Transaction]()
            }
            
            
        }
        
   
    }
    
    
    func getDeepestCategoryMatch(categories: [Category]) -> Category?{
        
        var match = categories.first
        var depth = 0
        if match != nil{
            for category in categories{
                if category.contains!.count > depth{
                    match = category
                    depth = category.contains!.count
                }
            }
        }
        return match
        
    }
    
    
}
