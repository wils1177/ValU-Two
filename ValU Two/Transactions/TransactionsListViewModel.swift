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
    var icons : [String] = ["🍩"]
    var rawTransaction: Transaction
    var idx : Int
    
}

class TransactionsListViewModel: ObservableObject, Presentor{
    
    @Published var transactions = [Transaction]()
    let dataManager = DataManager()
    @Published var viewData = [TransactionViewData]()
    var title : String?
    var budget : Budget
    var coordinator: TransactionRowDelegate?
    
    init(budget: Budget){
        //ToDo: Try-Catch this
        self.budget = budget
        fetchTransactionsForBudget()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
        
    }
    
    init(budget: Budget, categoryName: String){
        self.budget = budget
        self.title = categoryName
        if categoryName != names.otherCategoryName.rawValue{
            fetchTransactions(categoryName: categoryName)
        }
        else{
            fetchOtherTransactions()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    init(budget: Budget, predicate: NSPredicate, title: String = ""){
        self.title = title
        self.budget = budget
        fetchTransactions(predicate: predicate)
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
        
        
    }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: TransactionList(viewModel: self))
        vc.title = self.title!
        return vc
    }
    
    func fetchOtherTransactions(){
        
        var otherTransactions = [Transaction]()
        for catgegory in self.budget.getSubSpendingCategories(){
            if !catgegory.selected{
                for transactionMatch in catgegory.transactionMatches?.allObjects as! [CategoryMatch]{
                    if CommonUtils.isWithinBudget(transaction: transactionMatch.transaction!, budget: self.budget){
                        otherTransactions.append(transactionMatch.transaction!)
                    }
                    
                }
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
    
    //A way to fetch transactions for specific category
    func fetchTransactions(categoryName: String){
        self.transactions = [Transaction]()
        for spendingCategory in self.budget.getSubSpendingCategories(){
            if spendingCategory.name == categoryName{
                
                let categoryTransactions = spendingCategory.transactionMatches?.allObjects as! [CategoryMatch]
                //Only display the transactions that are within the budget dates
                for categoryMatch in categoryTransactions{
                    if CommonUtils.isWithinBudget(transaction: categoryMatch.transaction!, budget: self.budget){
                        self.transactions.append(categoryMatch.transaction!)
                    }
                }
            }
        }
        
    }
    
    
    
    @objc func update(_ notification:Notification){
        self.viewData.removeAll()
        
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
    
    

    


    
    func userClickedEditCategory(transaction: Transaction){
        
        self.coordinator?.showEditCategory(transaction: transaction)
        
    }
    
    
}
