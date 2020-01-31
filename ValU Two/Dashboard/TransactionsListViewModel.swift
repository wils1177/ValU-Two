//
//  TransactionsListViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import CoreData

struct TransactionViewData: Hashable {
    var name : String = ""
    var amount : String = ""
    var category : String = ""
    var date : String = ""
    var icon : String = "🍩"
    var rawTransaction: Transaction
    var idx : Int
    
}

class TransactionsListViewModel: ObservableObject{
    
    @Published var transactions = [Transaction]()
    let dataManager = DataManager()
    @Published var viewData = [TransactionViewData]()
    var budget : Budget?
    
    init(){
        //ToDo: Try-Catch this
        self.budget = try? dataManager.getBudget()
        fetchTransactionsForBudget()
        generateViewData()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
        
    }
    
    init(categoryName: String){
        self.budget = try? dataManager.getBudget()
        fetchTransactions(categoryName: categoryName)
        generateViewData()
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    init(predicate: NSPredicate){
        self.budget = try? dataManager.getBudget()
        fetchTransactions(predicate: predicate)
        generateViewData()
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
        
        
    }
    
    func fetchTransactions(predicate: NSPredicate){
        self.transactions = [Transaction]()
        do{
            self.transactions = try self.dataManager.getTransactions(predicate: predicate)
        }
        catch{
            self.transactions = [Transaction]()
        }
    }
    
    
    func fetchTransactions(categoryName: String){
        self.transactions = [Transaction]()
        for spendingCategory in self.budget!.getSubSpendingCategories(){
            if spendingCategory.category!.name == categoryName{
                self.transactions = spendingCategory.category!.transactions?.allObjects as! [Transaction]
            }
        }
        
    }
    
    
    
    @objc func update(_ notification:Notification){
        print("Update Triggered")
        self.viewData.removeAll()
        generateViewData()
        
    }
    
     func generateViewData(){
        var idx = 0
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
            let viewData = TransactionViewData(name: name ?? "No Name Available", amount: amount, category: category, date: presentationDate, icon: icon, rawTransaction: transaction, idx: idx)
            self.viewData.append(viewData)
            idx = idx + 1
        }
    }
    
    func fetchTransactionsForBudget(){
        
        self.transactions.removeAll()
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
