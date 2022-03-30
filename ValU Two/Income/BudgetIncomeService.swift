//
//  BudgetIncomeService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BudgetIncomeService : ObservableObject{
    var incomePredictionService : IncomePredictionService
    var budget : Budget
    @Published var currentIncomeEntry : String = "" {
        didSet {
            if currentIncomeEntry.prefix(1) != "$" && currentIncomeEntry != "" {
                currentIncomeEntry = "$" + currentIncomeEntry
            }
        }
    }
    
    init(budget : Budget){
        self.budget = budget
        
        if self.budget.timeFrame == 0{
            self.incomePredictionService = IncomePredictionService(timeFrame: TimeFrame.monthly)
        }else if self.budget.timeFrame == 1{
           self.incomePredictionService = IncomePredictionService(timeFrame: TimeFrame.semiMonthly)
        }
        else{
            self.incomePredictionService = IncomePredictionService(timeFrame: TimeFrame.weekly)
        }
        
        
        let intialIncome = getInitialIncome()
        if intialIncome == 0.0{
            self.currentIncomeEntry = ""
        }
        else{
            self.currentIncomeEntry = String(Int(intialIncome))
        }
        
    }
    
    func getInitialIncome() -> Double{
        let incomeAmount = self.budget.amount
        return Double(incomeAmount)
        
  
    }
    
    func getIncomeTransactions() -> [Transaction]{
        return self.incomePredictionService.getSortedIncomeTransactions()
    }
    
    func tryToSetBudgetIncome(){
        let incomeString = self.currentIncomeEntry.replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range:nil)

         let income = Double(incomeString) ?? 0
        
        if income != 0.0 {
            self.budget.amount = Float(income)
        }

    }
    
    func isValidState() -> Bool{
        let incomeString = self.currentIncomeEntry.replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range:nil)
        if incomeString != "" && (incomeString.doubleValue == nil || incomeString.doubleValue == 0.0){
            return false
        }
        return true
    }
    

    
}
