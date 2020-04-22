//
//  BudgetIncomeService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BudgetIncomeService : ObservableObject{
    var incomePredictionService  = IncomePredictionService()
    var budget : Budget
    @Published var currentIncomeEntry : String = ""
    
    init(budget : Budget){
        self.budget = budget
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
        
        if incomeAmount != 0.0{
            return Double(incomeAmount)
        }
        else{
            return self.incomePredictionService.getTotalIncome()
        }
  
    }
    
    func getIncomeTransactions() -> [Transaction]{
        return self.incomePredictionService.getSortedIncomeTransactions()
    }
    
    func tryToSetBudgetIncome(){
        let income = Double(self.currentIncomeEntry) ?? 0
        
        if income != 0.0 {
            self.budget.amount = Float(income)
        }
        
        if self.budget.budgetTimeFrame == nil{
            self.budget.budgetTimeFrame = TimeFrameManager().getCurrentTimeFrame()
        }

    }
    

    
}
