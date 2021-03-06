//
//  IncomePredictionService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

struct SelectableTransaction {
    var transaction : Transaction
    var selected = true
}


class IncomePredictionService{
    
    var transactions = [Transaction]()
    var selectableTransactions = [SelectableTransaction]()
    var timeFrame: TimeFrame
    
    init(timeFrame: TimeFrame){
        self.timeFrame = timeFrame
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
        
        if timeFrame == TimeFrame.monthly{
            return total * -1
        }
        else if timeFrame == TimeFrame.semiMonthly{
            return (total * -1) / 2
        }
        else{
            return (total * -1) / 4.7
        }
        
    }
    
    func getSortedIncomeTransactions() -> [Transaction]{
        
        return self.transactions.sorted(by: { $0.amount > $1.amount })
    }
    
    
    
    
    
}
