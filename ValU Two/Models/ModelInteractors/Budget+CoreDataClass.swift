//
//  Budget+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 9/7/19.
//
//

import Foundation
import CoreData

enum TimeFrame: Int32 {
    case monthly
    case semiMonthly
}

@objc(Budget)
public class Budget: NSManagedObject {
    

    
    func calculateSavingsAmount(percentageOfAmount: Float) -> Float{
        var calculation = percentageOfAmount * self.amount
        calculation = (calculation*100).rounded()/100
        return calculation
    }
    
    func isAmountEmpty() -> Bool {
        if self.amount == nil {
            return true
        }
        else{
            return false
        }
    }
    
    
    func setTimeFrame(timeFrame: TimeFrame) {
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
        let startOfMonth = Calendar.current.date(from: comp)
        
        if timeFrame == TimeFrame.monthly{
            self.timeFrame = TimeFrame.monthly.rawValue
            self.startDate = startOfMonth
            self.endDate = Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth!)
        }
        else if timeFrame == TimeFrame.semiMonthly{
            //Todo: A real implementation around semi monthly
            print("Semi Monthly does not really work yet")
            self.timeFrame = TimeFrame.semiMonthly.rawValue
            self.startDate = Date()
            self.endDate = Calendar.current.date(byAdding: .day, value: 15, to: Date())
        }
        
        
    }
    
    func getAmountAvailable() -> Float {
        return self.amount * (1 - self.savingsPercent)
    }
    

    
    func calculateAmountSpent() -> Double{
        
        do{
            print(startDate)
            let transactions = try DataManager().getTransactions(startDate: self.startDate!)
            var amountSpent : Double = 0
            
            for transaction in transactions{
                amountSpent = amountSpent + transaction.amount
            }
            return amountSpent
        }
        catch{
            return 0.0
        }
        
        
        
        
    }
    
    

}
