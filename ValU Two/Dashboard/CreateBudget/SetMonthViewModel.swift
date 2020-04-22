//
//  SetMonthViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class SetMonthViewModel: Presentor, ObservableObject{
    
    var budget : Budget
    var coordinator : NewBudgetCoordinator?
    var allBudgets : [Budget]
    var monthOptions = [String]()
    var currentSelectedMonth = 0
    var monthToDateTranslation : [String: Date]?
    var blackListedMonths : [String]?
    @Published var error  = false
    // Need to know the other months that already have budgets in them
    // Need to remove any of those months from the options list. 
    
    init(budget : Budget){
        self.budget = budget
        
        let futureQuery = PredicateBuilder().generateFutureBudgetPredicate(currentDate: Date())
        self.allBudgets = try! DataManager().getBudgets(predicate: futureQuery)
        //self.allBudgets.append(budget)
        
        self.monthToDateTranslation = getMonthTranslation()
        self.blackListedMonths = getBlackListedMonths()
        
    }
    
    func configure() -> UIViewController {
        return UIHostingController(rootView: MonthPickerView(viewModel: self))
    }
    
    
    func saveCurrentMonth(){
        
        self.error = tryToSaveMonth()
        
        if !self.error{
            self.coordinator?.setType()
        }
        
    }
    
    func tryToSaveMonth() -> Bool{
        
        let name = self.monthOptions[self.currentSelectedMonth]
        
        var error = false
        
        for blackListedMonth in self.blackListedMonths!{
            if name == blackListedMonth{
                error = true
            }
        }
        
        if !error{
            
            let newStartDate = self.monthToDateTranslation![name]
            let newEndDate = Calendar.current.date(byAdding: .month, value: 1, to: newStartDate!)!
            
            self.budget.startDate = newStartDate!
            self.budget.endDate = newEndDate
        }
        
        return error
    }
    
    func getMonthTranslation() -> [String:Date]{
        
        var monthDict = [String:Date]()
        var date = self.budget.startDate!
        
        for _ in 0...11{
            
            let name = getDateName(date: date)
            
            self.monthOptions.append(name)
            monthDict[name] = date
            
            date = Calendar.current.date(byAdding: .month, value: 1, to: date)!
        }
        
        return monthDict
    }
    
    func getBlackListedMonths() -> [String]{
        var blackListedMonths = [String]()
        for futureBudget in self.allBudgets{
            let date = futureBudget.startDate!
            let name = getDateName(date: date)
            blackListedMonths.append(name)
        }
        return blackListedMonths
    }
    
    func getDateName(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        
        return monthString + " " + yearString
    }
    
    
}
