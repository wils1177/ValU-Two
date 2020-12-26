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
    
    
    
    var budget: Budget
    var coordinator : SetSpendingLimitDelegate?
    @Published var percentage : Float = 0.0
    
    init(budget: Budget, coordinator: SetSpendingLimitDelegate){
        self.budget = budget
        let sections = budget.getBudgetSections()

        self.coordinator = coordinator
        

    }
    
    

  
    func getSpent() -> Float{
        
        var spent : Float = 0.0
        for section in self.budget.getBudgetSections(){
            spent = spent + Float(section.getLimit())
        }
        
        return spent
        
    }
    
    func getDisplaySpent() -> String{
        return String(roundToTens(x: getSpent()))
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
    
    func showNewSectionView(){
        self.coordinator?.showNewSectionView()
    }
    
    
    
    func roundToTens(x : Float) -> Int {
        return 10 * Int(round(x / 10.0))
    }
    
    
    func getBudgetStatusBarViewData() -> [BudgetStatusBarViewData]{
        
        var viewDataToReturn = [BudgetStatusBarViewData]()
        let amountAvailable = self.budget.getAmountAvailable()
        let spentTotal = self.getSpent()
        var total = amountAvailable
        
        if spentTotal > amountAvailable{
            total = Float(spentTotal)
        }
        

        
        var sectionSpentTotal = 0.0
        for section in self.budget.getBudgetSections(){
            let limitForSection = section.getLimit()
            let data = BudgetStatusBarViewData(percentage: limitForSection / Double(total), color: colorMap[Int(section.colorCode)], name: section.name!, icon: section.icon!)
            
            if limitForSection > 0.0 && limitForSection > 0.0{
                viewDataToReturn.append(data)
            }
            
        }
        
        viewDataToReturn.sort(by: { $0.percentage > $1.percentage })
        

        
        return viewDataToReturn
    }
    
    
    func deleteBudgetSection(section: BudgetSection){
        
        
        
        do{
            self.budget.removeFromBudgetSection(section)
              
            //try DataManager().deleteEntity(predicate: PredicateBuilder().generateByIdPredicate(id: id), entityName: "BudgetSection")
            print("section deleted")
            DataManager().saveDatabase()
            
        }
        catch{
            print("Could Not Delete Budget Section")
        }
        
        
        
        
        
        
 
        
        //self.objectWillChange.send()
        
    }

    
    
 
    
}
