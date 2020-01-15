//
//  CategoryTransactionsListViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class CategoryTransactionsViewModel : TransactionsListViewModel{
    
    
   //init(category: Category){
   // fetchTransactionsForCategory(category: category)
    //}
    
    func fetchTransactionsForCategory(category: Category){
        
        do{
            self.transactions = try dataManager.getTransactions(category: category)
        }
        catch{
            self.transactions = [Transaction]()
        }
        
    }
}
