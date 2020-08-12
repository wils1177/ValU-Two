//
//  SpendingSummaryViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class SpendingSummaryViewData: Hashable{
    static func == (lhs: SpendingSummaryViewData, rhs: SpendingSummaryViewData) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var icon: String
    var name: String
    var percentage: Float?
    var amount : String
    var displayPercent: String
    var rawAmount : Float
    var color : Color
    
    init(icon: String, name: String, percentage: Float?, amount: String, rawAmount: Float, displayPercent: String, color: Color){
        self.icon = icon
        self.color = color
        self.name = name
        self.percentage = percentage
        self.amount = amount
        self.rawAmount = rawAmount
        self.displayPercent = displayPercent
    }
}

class SpendingSummaryViewModel : ObservableObject{
    
    var spendingCategoryService = SpendingCategoryService()
    @Published var viewData = [SpendingSummaryViewData]()
    var buttonText = "See More"
    
    init(){
        
        generateViewData()
        
    }
    
    
    func generateViewData(){
        
        self.viewData.removeAll()
        
        TransactionProccessor(spendingCategories: self.spendingCategoryService.getSubSpendingCategories()).updateInitialThiryDaysSpent()

        var largest = Float(0.0)
            
        let spendingCategories = self.spendingCategoryService.getSubSpendingCategories()
        
            var total = Float(0.0)
            for spendingCategory in spendingCategories{
                
                let name = spendingCategory.name!
                let icon = spendingCategory.icon!
                let amount = spendingCategory.initialThirtyDaysSpent
                let amountString = "$" + String(Int(round(spendingCategory.initialThirtyDaysSpent)))
                total = total + amount
                
                if amount > largest{
                    largest = amount
                }
                
                if amount > 0.0{
                    
                    let entry = SpendingSummaryViewData(icon: icon, name: name, percentage: 0.5, amount: amountString, rawAmount: amount, displayPercent: "%0.0", color: colorMap[Int(spendingCategory.colorCode)])
                    self.viewData.append(entry)
                }
                
                
            }
            
            for entry in self.viewData{
                let displayPercent = String(format: "%.0f%%", entry.rawAmount / total * 100)
                entry.displayPercent = displayPercent
                entry.percentage = (entry.rawAmount / largest)
                if entry.percentage! < 0.04{
                    entry.percentage = 0.04
                }
            }
            
            self.viewData = self.viewData.sorted(by: { $0.rawAmount > $1.rawAmount })

            
            
        
        
    }
    
}
