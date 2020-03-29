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
    case otherCategoryName = "Not Budgeted"
}

class SpendingCategoryViewData: Hashable{
    var percentage : CGFloat = CGFloat(0.0)
    var spent : String = ""
    var limit : String = ""
    var name : String = ""
    var icon : String = "🍔"
    var id = UUID()
    
    init(percentage: CGFloat, spent: String, limit: String, name: String, icon: String) {
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
    var coordinator: HomeTabCoordinator?
    @Published var viewData = SpendingCardViewData()
    
    init(budget: Budget){
        self.budget = budget
        generateViewData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    @objc func update(_ notification:Notification){
        print("Spending Card Update Triggered")
        let dataManager = DataManager()
        dataManager.context.refreshAllObjects()
        
        
        //generateViewData()
        self.viewData = SpendingCardViewData()
        self.generateViewData()
        
    }
    

    
    func generateViewData(){
        
        var categories = [SpendingCategoryViewData]()
        let spendingCategories = self.budget.getSubSpendingCategories()
        var spendingCategoryLimitTotal = 0.0
        var selectedSpentTotal = 0.0
        
        for spendingCategory in spendingCategories{
            
            print(spendingCategory.name)
            if spendingCategory.name == "Breweries"{
                print(spendingCategory.name)
                print(spendingCategory.amountSpent)
            }
            
            if spendingCategory.selected{
                let name = (spendingCategory.name)!
                let spent = spendingCategory.amountSpent
                selectedSpentTotal = selectedSpentTotal + Double(spent)
                let limit = spendingCategory.limit
                spendingCategoryLimitTotal = spendingCategoryLimitTotal + Double(limit)
                let icon = spendingCategory.icon ?? "❓"
                var percentage = Float(0.0)
                if limit > 0.0 && spent > 0.0{
                    percentage = spent / limit
                }
                    
                    
                    
                let categoryViewData = SpendingCategoryViewData(percentage: CGFloat(percentage), spent: "$" + String(Int(round(spent))), limit: "$" + String(Int(round(limit))), name: name, icon: icon)
                    categories.append(categoryViewData)
            }
                
            
        }
        
        let otherName = names.otherCategoryName.rawValue
        let otherLimit = self.budget.getAmountAvailable() - Float(spendingCategoryLimitTotal)
        let otherIcon = "🔸"
        var otherPercentage = Float(0.0)
        let otherSpentTotal = self.budget.calculateOtherSpent()
        if otherLimit > 0.0 && otherSpentTotal > 0.0{
            otherPercentage = Float(otherSpentTotal) / otherLimit
        }
        
        let categoryViewData = SpendingCategoryViewData(percentage: CGFloat(otherPercentage), spent: "$" + String(Int(round(otherSpentTotal))), limit: "$" + String(Int(round(otherLimit))), name: otherName, icon: otherIcon)
        categories.append(categoryViewData)
        
        
        let cardName = "Budget"
        self.viewData = SpendingCardViewData(cardTitle: cardName, categories: categories)
        
    
    }
    

    
    
    
    
    
    
    
}
