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

class SpendingCategoryViewData: Hashable{
    var percentage : CGFloat = CGFloat(0.0)
    var spent : String = ""
    var limit : String = ""
    var name : String = ""
    var icon : String = "🍔"
    
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
        return lhs.name == rhs.name && lhs.limit == rhs.limit
    }
    
}

struct SpendingCardViewData{
    var cardTitle : String = ""
    var categories : [SpendingCategoryViewData] = [SpendingCategoryViewData]()
}

class SpendingCardViewModel: ObservableObject {
    
    var budget : Budget
    @Published var viewData = SpendingCardViewData()
    
    init(budget: Budget){
        self.budget = budget
        generateViewData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    @objc func update(_ notification:Notification){
           print("Spending Card Update Triggered")
           generateViewData()
           
       }
    

    
    func generateViewData(){
        
        var categories = [SpendingCategoryViewData]()
        let spendingCategories = self.budget.getSubSpendingCategories()
        for spendingCategory in spendingCategories{
            
            if spendingCategory.selected{
                
                let name = (spendingCategory.category?.name)!
                var spent = spendingCategory.amountSpent
                let limit = spendingCategory.limit
                let icon = spendingCategory.category!.icon ?? "❓"
                var percentage = Float(0.0)
                if limit > 0.0 && spent > 0.0{
                    percentage = spent / limit
                }
                
                
                
                let categoryViewData = SpendingCategoryViewData(percentage: CGFloat(percentage), spent: "$" + String(Int(round(spent))), limit: "$" + String(Int(round(limit))), name: name, icon: icon)
                categories.append(categoryViewData)
            }
            
            
        }
        
        
        let cardName = "Budget"
        self.viewData = SpendingCardViewData(cardTitle: cardName, categories: categories)
        
    
    }
    
    
    
}
