//
//  BudgetTypePresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class BudgetTypePresentor: Presentor, ObservableObject{
    var budget: Budget
    var coordinator: BudgetTypeDelegate?
    
    @Published var currentTimeSelected = 0
    @Published var currentRecurringSelected = 0
    
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var name = ""
    
    
    init(budget: Budget){
        self.budget = budget
        self.startDate = budget.startDate!
        self.endDate = budget.endDate!
        
        if budget.name! == "Placeholder"{
            budget.name = "Every Day Budget"
        }
        
        name = budget.name!
        
        self.currentRecurringSelected = Int(truncating: NSNumber(value: !self.budget.repeating))
        self.currentTimeSelected = getCurentTimeSelected(budget: budget)
    }
    
    func configure() -> UIViewController {
        return UIHostingController(rootView: BudgetTypeView(viewModel: self))
    }
    
    func getCurentTimeSelected(budget: Budget) -> Int{
        let timeFrame = self.budget.timeFrame
        
        if timeFrame == TimeFrame.monthly.rawValue{
            return 0
        }
        else if timeFrame == TimeFrame.semiMonthly.rawValue{
            return 1
        }
        else if timeFrame == TimeFrame.weekly.rawValue{
            return 2
        }
        return 0
    }
    
    
    func confirm() {
        
        self.budget.timeFrame = Int32(self.currentTimeSelected)
        self.budget.name = self.name
        self.budget.repeating = !Bool(exactly: NSNumber(integerLiteral: self.currentRecurringSelected))!
        setDates()
        
        self.coordinator?.confirmBudgetType()
        
    }
    
    func setDates(){
        let today = Date()
        if self.currentTimeSelected == 0{
            self.budget.startDate = today.startOfMonth!
            self.budget.endDate = today.endOfMonth!
        }
        else if self.currentTimeSelected == 1{
            self.budget.startDate = today.startOfMonth!
            self.budget.endDate = today.fifteenthOfMonth!
        }
        else if self.currentTimeSelected == 2{
            self.budget.startDate = today.startOfWeek!
            self.budget.endDate = today.endOfWeek!
        }
        else if self.currentTimeSelected == 3{
            self.budget.startDate = self.startDate
            self.budget.endDate = self.endDate
        }
        
        
    }
    
}
