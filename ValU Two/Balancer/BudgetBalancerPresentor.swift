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
        return CommonUtils.makeMoneyString(number: Int(getSpent()))
    }
    
    func getLeftToSpend() -> String{
    
        let available = self.budget.getAmountAvailable()
        
        let spent = getSpent()
        
        return CommonUtils.makeMoneyString(number: Int(available - spent))
        
    }
    
    
    func getPercentage() -> Float{
        let available = self.budget.getAmountAvailable()
        let spent = getSpent()
        
        
        return 1 - (spent / available)
        
        
   
    }
    
    func getAvailable() ->String{
        let available = self.budget.amount

        return CommonUtils.makeMoneyString(number: Int(available))
    }
    
    func showNewSectionView(){
        self.coordinator?.showNewSectionView()
    }
    
    
    
    func roundToTens(x : Float) -> Int {
        return 10 * Int(round(x / 10.0))
    }
    
    
    func getBudgetStatusBarViewData() -> [BudgetStatusBarViewData]{
        
        var viewDataToReturn = [BudgetStatusBarViewData]()
        let total = self.budget.amount
        

        
        var sectionSpentTotal = 0.0
        for section in self.budget.getBudgetSections(){
            let limitForSection = section.getLimit()
            let data = BudgetStatusBarViewData(percentage: limitForSection / Double(total), color: colorMap[Int(section.colorCode)] , name: section.name!, icon: section.icon!)
            sectionSpentTotal = sectionSpentTotal + limitForSection
            if limitForSection > 0.0 && limitForSection > 0.0{
                viewDataToReturn.append(data)
            }
            
        }
        
        viewDataToReturn.sort(by: { $0.percentage > $1.percentage })
        
        
        
        
        let savingsPercentage = self.budget.savingsPercent
        let savingsData = BudgetStatusBarViewData(percentage: Double(savingsPercentage), color: Color(.systemGreen), name: "Savings", icon: "dollarsign.circle")
        viewDataToReturn.insert(savingsData, at: 0)
        
        let otherTotal = total - Float(sectionSpentTotal) - (self.budget.savingsPercent * total)
        let otherPercentage = Float(otherTotal) / total
        let otherData = BudgetStatusBarViewData(percentage: Double(otherPercentage), color: Color(.systemGroupedBackground), name: "Free Spending", icon: "book")
        viewDataToReturn.append(otherData)
        
        

        
        return viewDataToReturn
    }
    
    
    func deleteBudgetSection(section: BudgetSection){
        
        
        
        do{
            self.budget.removeFromBudgetSection(section)
            DataManager().saveDatabase()
            
            try DataManager().deleteEntity(predicate: PredicateBuilder().generateByIdPredicate(id: section.id!), entityName: "BudgetSection")
            print("section deleted")
            
            DataManager().saveDatabase()
            self.objectWillChange.send()
        }
        catch{
            print("Could Not Delete Budget Section")
        }
        
        
        
        
        
        
 
        
        //self.objectWillChange.send()
        
    }

    
    
 
    
}
