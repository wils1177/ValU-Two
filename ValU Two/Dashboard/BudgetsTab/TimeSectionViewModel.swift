//
//  TimeSectionViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/11/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

struct CalendarEntryViewData: Hashable{
    var date : Date
    var dateName: String
    var amount : String
    var color : Color
    var future : Bool
    
    var id = UUID()
}

class TimeSectionViewModel{
    
    var budget: Budget
    var today : String
    var days = [Date]()
    
    var viewData = [CalendarEntryViewData]()
    var service : BudgetTransactionsService
    var startDate : String
    var endDate : String
    
    init(budget: Budget, service: BudgetTransactionsService){
        self.budget = budget
        self.service = service
        
        let monthInt = Calendar.current.component(.month, from: Date()) // 4
        let monthStr = Calendar.current.monthSymbols[monthInt-1] // April
        
        self.today = monthStr + " " + String(monthInt)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        
        self.startDate = dateFormatter.string(from: self.budget.startDate!)
        self.endDate = dateFormatter.string(from: self.budget.endDate!)
        
        self.days = getDaysInBudget().reversed()
        
        self.viewData = generateViewData()
        
        
        
        
    }
    
    func getDaysRemaining() -> String{
        
        let today = Date()
        let endDate = self.budget.endDate!
        
        let diffInDays = Calendar.current.dateComponents([.day], from: today, to: endDate).day
        
        return String(diffInDays!)
        
    }
    
    func getDaysInBudget() -> [Date]{
        var days = [Date]()
        var date = self.budget.startDate!
        let endDate = self.budget.endDate!
        
        while date <= endDate {
            days.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        return days
    }
    
    func generateViewData() -> [CalendarEntryViewData]{
        var viewData = [CalendarEntryViewData]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        
        for day in self.days{
            let dayName = dateFormatter.string(from: day)
            let rawAmount = getAmountForDate(date: day)
            let amount = CommonUtils.makeMoneyString(number: Int(getAmountForDate(date: day)))
            var future = false
            
            if day > Date(){
                future = true
            }
            
            if rawAmount >= 0{
                let entry = CalendarEntryViewData(date: day, dateName: dayName, amount: amount, color: Color(.systemGreen), future: future)
                viewData.append(entry)
            }
            else{
                let entry = CalendarEntryViewData(date: day,dateName: dayName, amount: amount, color: Color(.systemRed).opacity(0.80), future: future)
                viewData.append(entry)
            }

        }
        return viewData
    }
    
    func getAmountForDate(date: Date) -> Float{
        return self.service.sumTransactionsForDate(date: date)
    }
    
}

