//
//  TransactionsListViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

struct TransactionViewData: Hashable {
    var name : String = ""
    var amount : String = ""
    var category : String = ""
    var date : String = ""
    var icon : String = "🍩"
    var rawTransaction: Transaction
    var idx : Int
    
}

class TransactionsListViewModel: ObservableObject, Presentor{
    
    @Published var transactions = [Transaction]()
    let dataManager = DataManager()
    @Published var viewData = [TransactionViewData]()
    var budget : Budget
    var coordinator: TransactionRowDelegate?
    
    init(budget: Budget){
        //ToDo: Try-Catch this
        self.budget = budget
        fetchTransactionsForBudget()
        generateViewData()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
        
    }
    
    init(budget: Budget, categoryName: String){
        self.budget = budget
        if categoryName != names.otherCategoryName.rawValue{
            fetchTransactions(categoryName: categoryName)
        }
        else{
            fetchOtherTransactions()
        }
        
        generateViewData()
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    init(budget: Budget, predicate: NSPredicate){
        self.budget = budget
        fetchTransactions(predicate: predicate)
        generateViewData()
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
        
        
    }
    
    func configure() -> UIViewController {
        return UIHostingController(rootView: TransactionList(viewModel: self))
    }
    
    func fetchOtherTransactions(){
        
        fetchTransactionsForBudget()
        var foundSelected = false
        var otherTransactions = [Transaction]()
        for transaction in self.transactions{
            foundSelected = false
            for match in transaction.categoryMatches?.allObjects as! [SpendingCategory]{
                if match.selected == true{
                    foundSelected = true
                }
            }
            
            if !foundSelected{
                otherTransactions.append(transaction)
            }
        }
        
        self.transactions = otherTransactions
        
    }
    
    func fetchTransactions(predicate: NSPredicate){
        self.transactions = [Transaction]()
        do{
            self.transactions = try self.dataManager.getTransactions(predicate: predicate)
        }
        catch{
            self.transactions = [Transaction]()
            
        }
        //print(self.transactions)
    }
    
    
    func fetchTransactions(categoryName: String){
        self.transactions = [Transaction]()
        for spendingCategory in self.budget.getSubSpendingCategories(){
            if spendingCategory.name == categoryName{
                
                let categoryTransactions = spendingCategory.transactions?.allObjects as! [Transaction]
                //Only display the transactions that are within the budget dates
                for transaction in categoryTransactions{
                    if isWithinBudgetDates(transactionDate: transaction.date!){
                        self.transactions.append(transaction)
                    }
                }
            }
        }
        
    }
    
    
    
    @objc func update(_ notification:Notification){
        self.viewData.removeAll()
        generateViewData()
        
    }
    
     func generateViewData(){
        var idx = 0
        for transaction in self.transactions{
            
            
            
            let name = transaction.name
            let amount = String(format: "$%.02f", transaction.amount)
            let categoryMatches = transaction.categoryMatches!.allObjects as! [SpendingCategory]
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
            let startDate = self.budget.startDate
            let endDate = self.budget.endDate
            
            do{
                self.transactions = try dataManager.getTransactions(startDate: startDate!, endDate: endDate!)
            }
            catch{
                self.transactions = [Transaction]()
            }
            
            
        }
        
   
    }
    
    
    func getDeepestCategoryMatch(categories: [SpendingCategory]) -> SpendingCategory?{
        
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
    
    func isWithinBudgetDates(transactionDate: Date) -> Bool{
        
        let startDate = self.budget.startDate!
        let endDate = self.budget.endDate!
        
        return (startDate ... endDate).contains(transactionDate)
        
    }
    
    func userClickedEditCategory(transaction: Transaction){
        
        self.coordinator?.showEditCategory(transaction: transaction)
        
    }
    
    
}
