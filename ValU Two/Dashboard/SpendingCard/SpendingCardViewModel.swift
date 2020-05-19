//
//  SpendingCardPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

import SwiftUI
import CoreData

enum names : String{
    case otherCategoryName = "Everything Else"
}


class SpendingCategoryViewData: Hashable, Identifiable{
    var percentage : CGFloat = CGFloat(0.0)
    var spent : Float
    var limit : Float
    var name : String = ""
    var icon : String = "🍔"
    var id = UUID()
    
    init(percentage: CGFloat, spent: Float, limit: Float, name: String, icon: String) {
        self.percentage = percentage
        self.limit = limit
        self.spent = spent
        self.name = name
        self.icon = icon
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(limit)

    }
    
    static func == (lhs: SpendingCategoryViewData, rhs: SpendingCategoryViewData) -> Bool {
        return lhs.name == rhs.name && lhs.limit == rhs.limit && rhs.id == lhs.id
    }
    
}

struct SpendingCardViewData{
    var cardTitle : String = ""
    var categories : [SpendingCategoryViewData] = [SpendingCategoryViewData]()
}

class SpendingCardViewModel: ObservableObject {
    
    var budget : Budget
    var coordinator: BudgetsTabCoordinator?
    @Published var categories = [SpendingCategory]()
    var subCategories = [SpendingCategory]()
    @Published var otherCategory : SpendingCategoryViewData?
    var viewData = SpendingCardViewData()
    var services  = [BalanceParentService]()
    
    init(budget: Budget){
        self.budget = budget
        self.categories = budget.getParentSpendingCategories()
        self.subCategories = budget.getSubSpendingCategories()
        makeOtherCategory()
        makeServices()
    }
    
    func makeServices(){
        for category in categories{
            let service = BalanceParentService(spendingCategory: category)
            self.services.append(service)
        }
    }
    
    func makeOtherCategory(){
        
        var spendingCategoryLimitTotal = 0.0
        var selectedSpentTotal = 0.0
        
        for spendingCategory in self.subCategories{
            
            if spendingCategory.selected{
                let spent = spendingCategory.getAmountSpent()
                selectedSpentTotal = selectedSpentTotal + Double(spent)
                let limit = spendingCategory.limit
                spendingCategoryLimitTotal = spendingCategoryLimitTotal + Double(limit)
            }
                
            
        }
        
        let otherName = "Not Budgeted"
        let otherLimit = self.budget.getAmountAvailable() - Float(spendingCategoryLimitTotal)
        let otherIcon = "🔸"
        var otherPercentage = Float(0.0)
        let otherSpentTotal = getOtherSpent()
        if otherLimit > 0.0 && otherSpentTotal > 0.0{
            otherPercentage = Float(otherSpentTotal) / otherLimit
        }
        
        let categoryViewData = SpendingCategoryViewData(percentage: CGFloat(otherPercentage), spent: otherSpentTotal, limit: otherLimit, name: otherName, icon: otherIcon)
        self.otherCategory = categoryViewData
        
        
        
    }
    
    func editBudget(){
        self.coordinator?.editClicked(budgetToEdit: self.budget)
    }
    
    func getOtherSpent() -> Float{
        var otherTotal = 0.0
        for transaction in self.budget.transactions!.allObjects as! [Transaction]{
            if transaction.amount > 0{
                var isSelected = false
                for match in transaction.categoryMatches?.allObjects as! [CategoryMatch]{
                    if match.spendingCategory!.selected{
                        isSelected = true
                    }
                }
                if !isSelected{
                    otherTotal = otherTotal + transaction.amount
                }
            }
        }
        return Float(otherTotal)
    }
    

    
    /*
    @objc func update(_ notification:Notification){
        print("Spending Card Update Triggered")
        let dataManager = DataManager()
        dataManager.context.refreshAllObjects()
        
        
        //generateViewData()
        self.viewData = SpendingCardViewData()
        self.generateViewData()
        
    }
    */

    
    
    
    
    
    
    
    
}
