//
//  BudgetBalancerPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI



enum BudgetContinueResponse {
    case CanContinue
    case BudgetEmpty
    case OverBudget
}

class BudgetBalancerPresentor : ObservableObject {
    
    
    
    var budget: Budget
    var coordinator : SetSpendingLimitDelegate?
    @Published var percentage : Float = 0.0
    
    var sections : [BudgetSection]
    
    var historicalTransactionsModel : HistoricalTransactionsViewModel
    
    init(budget: Budget, coordinator: SetSpendingLimitDelegate){
        self.budget = budget
        self.sections = budget.getBudgetSections()
        self.historicalTransactionsModel = HistoricalTransactionsViewModel(timeFrame: self.budget.timeFrame)
        self.coordinator = coordinator
        

    }
    
    

  
    func getSpent() -> Float{
        
        var spent : Float = 0.0
        for section in self.budget.getBudgetSections(){
            spent = spent + Float(section.getLimit())
        }
        
        spent = spent + (self.budget.savingsPercent * self.budget.amount)
        
        return spent
        
    }
    
    func getAmountRemaining() -> Float{

        let amountAvailable = self.budget.amount
        let spent = getSpent()
        return amountAvailable - spent
    }
    
    func getDisplayAmountRemaining() -> String{
        return CommonUtils.makeMoneyString(number: Int(getAmountRemaining())) + " Left"
    }
    
    func getDisplaySpent() -> String{
        return CommonUtils.makeMoneyString(number: Int(getSpent()))
    }
    
    func getDisplayPercentageForSection(section: BudgetSection) -> String{
        let limit = section.getLimit()
        let total = self.budget.amount
        let percentage = (limit / Double(total)) * 100.0
        
        return String(Int(percentage)) + "%"
        
        
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
            //if limitForSection > 0.0 && limitForSection > 0.0{
                viewDataToReturn.append(data)
            //}
            
        }
        
        viewDataToReturn.sort(by: { $0.percentage > $1.percentage })
        
        
        
        
        let savingsPercentage = self.budget.savingsPercent
        let savingsData = BudgetStatusBarViewData(percentage: Double(savingsPercentage), color: Color(.systemGreen), name: "Savings", icon: "dollarsign.circle")
        viewDataToReturn.insert(savingsData, at: 0)
        
        let otherTotal = total - Float(sectionSpentTotal) - (self.budget.savingsPercent * total)
        let otherPercentage = Float(otherTotal) / total
        let otherData = BudgetStatusBarViewData(percentage: Double(otherPercentage), color: Color(.tertiarySystemGroupedBackground), name: "Free Spending", icon: "book")
        viewDataToReturn.append(otherData)
        
        

        
        return viewDataToReturn
    }
    
    
    func deleteBudgetSection(section: BudgetSection){
        
        
        
        do{
            self.budget.removeFromBudgetSection(section)
            DataManager().saveDatabase()
            self.budget.objectWillChange.send()
            
            
            try DataManager().deleteEntity(predicate: PredicateBuilder().generateByIdPredicate(id: section.id!), entityName: "BudgetSection")
            print("section deleted")
            
            DataManager().saveDatabase()
            
        }
        catch{
            print("Could Not Delete Budget Section")
        }
        
        
        
        
        
 
        
        //self.objectWillChange.send()
        
    }

    
    func deleteCategory(id: UUID, budgetSection: BudgetSection) {
        
        for category in budgetSection.budgetCategories?.allObjects as! [BudgetCategory]{
            if category.id! == id{
                budgetSection.removeFromBudgetCategories(category)
                let predicate = PredicateBuilder().generateByIdPredicate(id: category.id!)
                category.spendingCategory!.objectWillChange.send()
                self.objectWillChange.send()
                do{
                    try DataManager().deleteEntity(predicate: predicate, entityName: "BudgetCategory")
                }
                catch{
                    print("WARNING: Could delete budget category entity")
                }
            
                
            }
        }
        self.objectWillChange.send()
        
    }
    
    
    func requestToContinue() -> BudgetContinueResponse{
        let amountLimited = self.budget.getAmountLimited()
        let available = self.budget.getAmountAvailable()
        
        if amountLimited > 0.0 && amountLimited <= available {
            return BudgetContinueResponse.CanContinue
        }
        else if amountLimited > 0.0 && amountLimited > available{
            return BudgetContinueResponse.OverBudget
        }
        else {
            return BudgetContinueResponse.BudgetEmpty
        }
    }
 
    
}
