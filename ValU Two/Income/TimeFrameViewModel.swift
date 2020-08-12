//
//  TimeFrameViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class TimeFrameViewModel: ObservableObject{
    
    var budget : Budget
    @Published var currentTimeFrame : TimeFrame?
    
    var coordinator: IncomeCoordinator?
    
    init(budget: Budget){
        self.budget = budget
        
        if budget.timeFrame == -1{
            budget.timeFrame = 0
        }
        
        if budget.timeFrame == 0{
            self.currentTimeFrame = TimeFrame.monthly
        }
        else if budget.timeFrame == 1{
            self.currentTimeFrame = TimeFrame.semiMonthly
        }
        else{
            self.currentTimeFrame = TimeFrame.weekly
        }
    }
    
    
    
    func toggleTimeFrame(timeFrame: TimeFrame){
        if self.currentTimeFrame == timeFrame{
            self.currentTimeFrame = nil
        }
        else{
            self.currentTimeFrame = timeFrame
        }
        
    }
    
    func isTimeFrameSelected(timeFrame: TimeFrame) -> Bool{
        if timeFrame == currentTimeFrame{
            return true
        }
        else{
            return false
        }
    }
    
    func canSubmit() -> Bool{
        if currentTimeFrame != nil{
            return true
        }
        else{
            return false
        }
    }
    
    func submitResult(){
        
        if self.currentTimeFrame != nil{
            self.budget.setTimeFrame(timeFrame: self.currentTimeFrame!)
        }
        
        self.coordinator?.timeFrameSubmitted()
        DataManager().saveDatabase()
        
        
    }
    
    
    
}
