//
//  BudgetBalancerPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI



class BudgetBalancerPresentor : ObservableObject {
    
    
    
    @Published var budget: Budget
    var coordinator : SetSpendingLimitDelegate?
    var parentCategories : [SpendingCategory]
    var parentServices = [BalanceParentService]()
    @Published var percentage : Float = 0.0
    
    init(budget: Budget, coordinator: SetSpendingLimitDelegate){
        self.budget = budget
        let categories = budget.getParentSpendingCategories()
        self.parentCategories = categories
        self.coordinator = coordinator
        
        for category in categories{
            let service = BalanceParentService(spendingCategory: category)
            self.parentServices.append(service)
        }
    }
    

  
    func getSpent() -> Float{
        
        var spent : Float = 0.0
        for category in self.parentServices{
            spent = spent + category.getParentLimit()
        }
        
        return spent
        
    }
    
    func getLeftToSpend() -> String{
    
        let available = self.budget.getAmountAvailable()
        
        let spent = getSpent()
        
        return String(roundToTens(x: available) - roundToTens(x: spent))
        
    }
    
    func getPercentage() -> Float{
        let available = self.budget.getAmountAvailable()
        let spent = getSpent()
        
        
        return 1 - (spent / available)
        
        
   
    }
    
    func getAvailable() ->String{
        let available = self.budget.getAmountAvailable()
        
        
        return "$" + String(roundToTens(x: available))
    }
    
    
    
    func roundToTens(x : Float) -> Int {
        return 10 * Int(round(x / 10.0))
    }

    
    
 
    
}
