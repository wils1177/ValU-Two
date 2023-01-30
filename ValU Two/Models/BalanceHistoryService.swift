//
//  BalanceHistoryService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/17/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import Foundation

struct BalanceHistoryTotal: Identifiable{
    var date: Date
    var balanceTotal: Double
    var id = UUID()
}

class BalanceHistoryService{
    
    let dataManager = DataManager()
    
    func snapShotBalanceHistory(){
        
        let accounts = dataManager.getAccounts()
        let currentDate = Date().onlyDate!
        
        for account in accounts{
            
            let accountId = account.accountId
            let existingEntry = checkIfAccountAndDateExist(accountId: accountId!, date: currentDate)
            
            var balance = 0.0
            if account.type == "credit"{
                balance = account.balances!.current * -1
            }
            else{
                balance = account.balances!.available
            }
            
            if  existingEntry != nil{
                existingEntry!.balance = balance
                dataManager.saveDatabase()
                print("Update a account history entry for:")
                print(accountId!)
            }
            else{
                
                let _ = dataManager.createBalanceHistory(accountId: accountId!, date: currentDate, balance: balance)
                dataManager.saveDatabase()
                print("saved a new account history entry for:")
                print(accountId!)
            }
            
        }
        
        
        
    }
    
    func checkIfAccountAndDateExist(accountId: String, date: Date) -> BalanceHistory?{
        let predicate = PredicateBuilder().generateAccoutnIdAndDatePredicate(accountId: accountId, date: date)
        let entityName = "BalanceHistory"
        
        do{
            let result = try dataManager.getEntity(predicate: predicate, entityName: entityName)
            if result.count == 0{
                return nil
            }
            else{
                return result[0] as? BalanceHistory
            }
        }
        catch{
            return nil
        }
        
        
    }
    
    func getTotalBalanceHistoryforDateRange(startDate: Date, endDate: Date) -> [BalanceHistoryTotal]{
        let predicate = PredicateBuilder().generateInDatesPredicate(startDate: startDate, endDate: endDate)
        
        do{
            let history = try dataManager.getEntity(predicate: predicate, entityName: "BalanceHistory") as! [BalanceHistory]
            
            return createAccountBalanceTotals(history: history)
            
        }
        catch{
            print("Could not pull in history")
            return [BalanceHistoryTotal]()
        }
        
    }
    
    
    func createAccountBalanceTotals(history: [BalanceHistory]) -> [BalanceHistoryTotal]{
        
        
        
        let dateArray = history.compactMap { $0.date}
        let dateSet = Set(dateArray)
        
        var totals = [BalanceHistoryTotal]()
        
        dateSet.forEach {
            let dateKey = $0
            let filterArray = history.filter { $0.date == dateKey}
            var amount = 0.0
            for entry in filterArray{
                
                amount = amount + entry.balance
                
                
            }
            
            let dateTotal = BalanceHistoryTotal(date: dateKey, balanceTotal: amount)
            totals.append(dateTotal)
            
            
        }
        
        return totals
        
    }
    
     
    
    
}

extension Date {

    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
    }

}
