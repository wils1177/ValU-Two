//
//  BudgetCopyer.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BudgetCopyer{
    
    
    func copyBudget(budget: Budget) -> Budget{
        
        let newBudget = budget.copy() as! Budget
        
        newBudget.spent = Float(0.0)
        newBudget.inflow = Float(0.0)
        
        
                
        DataManager().saveDatabase()
        return newBudget
    }
    
    func copyBudgetForNextPeriod(budget: Budget)->Budget{
        let newBudget = copyBudget(budget: budget)
        budget.active = false
        newBudget.active = true
        DataManager().saveDatabase()
        return newBudget
    }
    
    
    func checkIfBudgetIsOutdated(){
        
        let currentBudget = try? DataManager().getBudget()
        
        if currentBudget != nil{
            
            let currentDate = Date()
            print(currentDate)
            let startDate = currentBudget!.startDate
            print(startDate)
            let endDate = currentBudget!.endDate
            print(endDate)
            
            if !(startDate! ... endDate!).contains(currentDate){
                print("BUDGET IS OUTDATED")
                self.copyBudgetForNextPeriod(budget: currentBudget!)
                
            }
            
        }
    }
    
  
    
    
    
    
}
