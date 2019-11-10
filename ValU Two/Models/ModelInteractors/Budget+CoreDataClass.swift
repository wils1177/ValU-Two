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
        
        if timeFrame == TimeFrame.monthly{
            self.timeFrame = TimeFrame.monthly.rawValue
            self.startDate = Date()
            self.endDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        }
        else if timeFrame == TimeFrame.semiMonthly{
            self.timeFrame = TimeFrame.semiMonthly.rawValue
            self.startDate = Date()
            self.endDate = Calendar.current.date(byAdding: .day, value: 15, to: Date())
        }
        
        
    }
    
    

}
