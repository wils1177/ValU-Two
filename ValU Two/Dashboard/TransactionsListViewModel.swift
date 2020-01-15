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
    
}

class TransactionsListViewModel{
    
    var transactions = [Transaction]()
    let dataManager = DataManager()
    var viewData = [TransactionViewData]()
    var budget : Budget?
    
    init(){
        self.budget = try? dataManager.getBudget()
        fetchTransactionsForBudget()
        generateViewData()
    }
    
    func generateViewData(){
        for transaction in self.transactions{
            let name = transaction.name
            let amount = String(format: "$%.02f", transaction.amount)
            let category = transaction.category?.name ?? "Uncategorized"
            let executionDate = transaction.date!
            let icon = transaction.category?.icon ?? "❓"
            let df = DateFormatter()
            df.dateFormat = "MM-dd"
            let presentationDate = df.string(from: executionDate)
            let viewData = TransactionViewData(name: name ?? "No Name Available", amount: amount, category: category, date: presentationDate, icon: icon)
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
    
    
}
