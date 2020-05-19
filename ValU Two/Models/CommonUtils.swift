//
//  CommonUtils.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/1/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class CommonUtils{
    static func isWithinBudget(transaction: Transaction, budget: Budget) -> Bool{
        
        let startDate = budget.startDate!
        let endDate = budget.endDate!
        
        return (startDate ... endDate).contains(transaction.date!) && !transaction.isHidden
        
    }
    
    static func getMonthFromDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: date)
        let title = nameOfMonth
        return title
    }
    
    static func getMonthYear(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-yyyy"
        let nameOfMonth = dateFormatter.string(from: date)
        let title = nameOfMonth
        return title
    }
    
    static func getParentSpendingCategories() -> [SpendingCategory]{
        var spendingCategoriesToReturn = [SpendingCategory]()
        do{
            let spendgingCategories = try DataManager().getEntity(entityName: "SpendingCategory") as! [SpendingCategory]
            for category in spendgingCategories{
                if category.subSpendingCategories != nil && (category.subSpendingCategories!.allObjects as! [SpendingCategory]).count > 0{
                    spendingCategoriesToReturn.append(category)
                }
            }
        }
        catch{
            print("COULD NOT FETCH SPENDING CATEGORIES")
        }
        
        return spendingCategoriesToReturn
    }
    
    static func getSubSpendingCategories() -> [SpendingCategory]{
         var spendingCategoriesToReturn = [SpendingCategory]()
         do{
             let spendgingCategories = try DataManager().getEntity(entityName: "SpendingCategory") as! [SpendingCategory]
             for category in spendgingCategories{
                 if category.subSpendingCategories == nil || (category.subSpendingCategories!.allObjects as! [SpendingCategory]).count == 0{
                     spendingCategoriesToReturn.append(category)
                 }
             }
         }
         catch{
             print("COULD NOT FETCH SPENDING CATEGORIES")
         }
         
         return spendingCategoriesToReturn
        
    }
    
    static func makeMoneyString(number: Int) -> String{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        var moneyString = numberFormatter.string(from: NSNumber(value:number))!
        moneyString.removeLast(3)
        return moneyString
    }
    
    static func makeMoneyString(number: Double) -> String{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let moneyString = numberFormatter.string(from: NSNumber(value:number))!
        return moneyString
    }
    
    
}



extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return sunday
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var startOfMonth: Date?{
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: self)
        let startOfMonth = Calendar.current.date(from: comp)!
        return startOfMonth
    }
    
    var fifteenthOfMonth : Date?{
        let fifteenth = Calendar.current.date(byAdding: .weekOfYear, value: 2, to: self)
        return fifteenth
    }
    
    var endOfMonth: Date?{
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: self)
        let startOfMonth = Calendar.current.date(from: comp)!
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = Calendar.current.date(byAdding: comps2, to: startOfMonth)
        return endOfMonth
    }
}
