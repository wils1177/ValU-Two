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



class TransactionsListViewModel: ObservableObject, Presentor{
    
    @Published var transactions = [Transaction]()
    let dataManager = DataManager()
    var title : String
    var coordinator: TransactionRowDelegate?
    

    init(predicate: NSPredicate, title: String = ""){
        self.title = title
        self.fetchTransactions(predicate: predicate)

    }
    
    init(predicate: NSCompoundPredicate){
        self.title = ""
        self.fetchTransactions(predicate: predicate)

    }
    
    init(transactions: [Transaction], title: String = ""){
        self.title = title
        self.transactions = transactions
        //self.transactions = self.transactions.sorted(by: {$0.date!.compare($1.date!) == .orderedDescending})
    }
    

    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: TransactionList(viewModel: self))
        vc.title = self.title
        return vc
    }
    

    
    func fetchTransactions(predicate: NSPredicate){
        self.transactions = [Transaction]()
        do{
            self.transactions = try self.dataManager.getTransactions(predicate: predicate)
        }
        catch{
            self.transactions = [Transaction]()
            
        }
        //self.transactions = self.transactions.sorted(by: {$0.date!.compare($1.date!) == .orderedDescending})
        //print(self.transactions)
    }
    
    func fetchTransactions(predicate: NSCompoundPredicate){
        self.transactions = [Transaction]()
        do{
            self.transactions = try self.dataManager.getTransactions(predicate: predicate)
        }
        catch{
            self.transactions = [Transaction]()
            
        }
        //self.transactions = self.transactions.sorted(by: {$0.date!.compare($1.date!) == .orderedDescending})
    }


    
    func userClickedEditCategory(transaction: Transaction){
        
        self.coordinator?.showEditCategory(transaction: transaction)
        
    }
    
    
}
