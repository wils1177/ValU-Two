//
//  ThisMonthLastMonthService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/26/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import Foundation

class ThisMonthLastMonthService : ObservableObject {
    
    
    
    static func createLegendValues(start: Date, end: Date) -> [Date]{
        var dateList = [Date]()
        var dateIncrement = start
        while dateIncrement < end{
            dateList.append(dateIncrement)
            dateIncrement = Calendar.current.date(byAdding: .day, value: 1, to: dateIncrement)!
        }
        
        return dateList

    }
    
    static func createDataPoints(start: Date, end: Date, transactions: [Transaction], income: Bool = false) -> [BalanceHistoryTotal]{
        

        let dateSortedTransactions = transactions.sorted(by: { $0.date! < $1.date! })
        
        var spendingTotalByDay = [BalanceHistoryTotal]()
        var spendingTotal = 0.0
        //spendingTotalByDay.append(spendingTotal)
        
        var dateIncrement = start.stripTime()
        
        var factor = 1.0
        if income {
            factor = -1.0
        }
        
        for transaction in dateSortedTransactions{
            
                
            let transactionDate = transaction.date!.stripTime()
                // If we don't have any transactions for the current date, just copy over until we get there.
                while dateIncrement < transactionDate{
                    spendingTotalByDay.append(BalanceHistoryTotal(date: dateIncrement, balanceTotal: spendingTotal * factor))
                    dateIncrement = Calendar.current.date(byAdding: .day, value: 1, to: dateIncrement)!
                    //print("copy over day gap")
                }
                 
                // If we are looking at transactions for the right date, add up to the sum
                if transactionDate == dateIncrement{
                    let categoryMatches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
                    if categoryMatches.count > 0{
                        for categoryMatch in categoryMatches {
                            spendingTotal = spendingTotal + Double(categoryMatch.amount)
                        }
                    }
                    else{
                        spendingTotal = spendingTotal + transaction.amount
                    }
                }
                
                //If we reach a transaction that is past the current date
                if transactionDate > dateIncrement{
                    spendingTotalByDay.append(BalanceHistoryTotal(date: dateIncrement, balanceTotal: spendingTotal * factor))
                    dateIncrement = Calendar.current.date(byAdding: .day, value: 1, to: dateIncrement)!
                    //print("finished with a day")
                }
                
            
            
            
            
        }
        
        //If we are done with all the transactions, but there still some dates to go.
        while dateIncrement <= end.stripTime(){
            spendingTotalByDay.append(BalanceHistoryTotal(date: dateIncrement, balanceTotal: spendingTotal * factor))
            dateIncrement = Calendar.current.date(byAdding: .day, value: 1, to: dateIncrement)!
            //print("Done with transactions, but there are still more days. ")
        }
        
        
        return spendingTotalByDay
    }
    
    
}
