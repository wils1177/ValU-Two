//
//  IncomePredictionService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation


class IncomePredictionService{
    
    var transactions = [Transaction]()
    
    init(){
        
        getPreviousIncomeTransactions()
        
    }
    
    func getPreviousIncomeTransactions(){
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: endDate)!
        
        let query = PredicateBuilder().generateNegativeAmountPredicate(startDate: startDate, endDate: endDate)
        
        do {
            let results = try DataManager().getEntity(predicate: query, entityName: "Transaction") as! [Transaction]
            self.transactions = results
        }
        catch{
            let emptyTransactions = [Transaction]()
            self.transactions = emptyTransactions
        }
    }
    
    func getTotalIncome() -> Double{
        var total = 0.0
        for transaction in self.transactions{
            total = total + transaction.amount
        }
        return total * -1
    }
    
    func getSortedIncomeTransactions() -> [Transaction]{
        
        return self.transactions.sorted(by: { $0.amount > $1.amount })
    }
    
    
    
    
    
}
