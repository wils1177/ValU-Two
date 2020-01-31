//
//  SpendingSummaryViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

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
    
    init(icon: String, name: String, percentage: Float?, amount: String, rawAmount: Float, displayPercent: String){
        self.icon = icon
        self.name = name
        self.percentage = percentage
        self.amount = amount
        self.rawAmount = rawAmount
        self.displayPercent = displayPercent
    }
}

class SpendingSummaryViewModel : ObservableObject{
    
    var budget : Budget?
    @Published var viewData = [SpendingSummaryViewData]()
    var condensed = true
    var buttonText = "See More"
    
    init(){
        do{
            self.budget = try DataManager().getBudget()
        }
        catch{
            self.budget = nil
        }
        
        generateViewData()
        
    }
    
    func toggleCondesnsed(){
        self.condensed.toggle()
        if self.buttonText == "See More"{
            self.buttonText = "See Less"
        }else{
            self.buttonText = "See More"
        }
        
        self.generateViewData()
    }
    
    func generateViewData(){
        
        self.viewData.removeAll()
        
        var largest = Float(0.0)
        if self.budget != nil{
            
            let spendingCategories = self.budget!.getSubSpendingCategories()
            var total = Float(0.0)
            for spendingCategory in spendingCategories{
                
                let name = spendingCategory.category!.name!
                let icon = spendingCategory.category!.icon!
                let amount = spendingCategory.amountSpent
                let amountString = "$" + String(Int(round(spendingCategory.amountSpent)))
                total = total + amount
                
                if amount > largest{
                    largest = amount
                }
                
                if amount > 0.0{
                    
                    let entry = SpendingSummaryViewData(icon: icon, name: name, percentage: 0.5, amount: amountString, rawAmount: amount, displayPercent: "%0.0")
                    self.viewData.append(entry)
                }
                
                
            }
            
            
            for entry in self.viewData{
                let displayPercent = String(format: "%.0f%%", entry.rawAmount / total * 100)
                entry.displayPercent = displayPercent
                entry.percentage = (entry.rawAmount / largest)
            }
            
            self.viewData = self.viewData.sorted(by: { $0.rawAmount > $1.rawAmount })
            if self.condensed{
                self.viewData = Array(self.viewData.prefix(5))
            }
            
            
        }
        
    }
    
}
