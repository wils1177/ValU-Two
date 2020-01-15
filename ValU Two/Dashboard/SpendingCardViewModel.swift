//
//  SpendingCardPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

import SwiftUI

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

class SpendingCardViewModel {
    
    var budget : Budget
    var viewData = SpendingCardViewData()
    
    init(budget: Budget){
        self.budget = budget
        self.viewData = generateViewData()
    }
    
    func generateViewData() -> SpendingCardViewData{
        
        var categories = [SpendingCategoryViewData]()
        for case let spendingCategory as SpendingCategory in self.budget.spendingCategories!{
            
            let name = (spendingCategory.category?.name)!
            let spent = spendingCategory.amountSpent
            let limit = spendingCategory.limit
            let icon = spendingCategory.category!.icon ?? "❓"
            var percentage = Float(0.0)
            if limit > 0.0 && spent > 0.0{
                percentage = spent / limit
            }
            
            
            
            let categoryViewData = SpendingCategoryViewData(percentage: CGFloat(percentage), spent: String(spent), limit: String(limit), name: name, icon: icon)
            categories.append(categoryViewData)
        }
        
        
        let cardName = "Spending"
        return SpendingCardViewData(cardTitle: cardName, categories: categories)
        
    
    }
    
    
    
}
