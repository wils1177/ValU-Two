//
//  BudgetBalancerPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class BalanceCategoryViewData : ObservableObject, Hashable {

    var name : String
    var icon: String
    var lastThirtyDaysSpent : String
    var index = 0
    @Published var limit : String
    
    init(name: String, icon: String, limit: String, lastThirtyDaysSpent: String) {
        self.name = name
        self.icon = icon
        self.limit = limit
        self.lastThirtyDaysSpent = lastThirtyDaysSpent
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)

    }
    
    static func == (lhs: BalanceCategoryViewData, rhs: BalanceCategoryViewData) -> Bool {
        return lhs.name == rhs.name && lhs.limit == rhs.limit
    }
}

class BudgetBalancerPresentor : Presentor, ObservableObject, KeyboardDelegate {
    
    
    
    var budget: Budget
    var coordinator : SetSpendingLimitDelegate?
    @Published var viewData = [BalanceCategoryViewData]()
    @Published var leftToSpend : String?
    var categoryPicker : CategoryPickerPresentor
    @Published var percentage : Float = 0.0
    
    init(budget: Budget){
        self.budget = budget
        self.categoryPicker = CategoryPickerPresentor(budget: self.budget)
        categoryPicker.delegate = self
        self.categoryPicker.generateViewData()
        calculateLeftToSpend()
        generateViewData()
    }
    
    func configure() -> UIViewController {
        return UIHostingController(rootView: BalancerView(viewModel: self))
    }
    
    func generateViewData(){
        
        self.viewData = [BalanceCategoryViewData]()
        var index = 0
        let available = self.budget.getAmountAvailable()
        let spent = getSpent()
        self.percentage = spent / available
        
        for spendingCategory in self.budget.getSubSpendingCategories(){
            if spendingCategory.selected{
                
                var limit = ""
                if spendingCategory.limit != 0.0{
                    limit = String(roundToTens(x: spendingCategory.limit))
                }
                
                
                
                let name = spendingCategory.name
                let lastThirtyDaysSpent = spendingCategory.initialThirtyDaysSpent
                let viewCategory = BalanceCategoryViewData(name : name!, icon: spendingCategory.icon!, limit: limit, lastThirtyDaysSpent: "$" + String(roundToTens(x: lastThirtyDaysSpent)))
                viewCategory.index = index
                index = index + 1
                self.viewData.append(viewCategory)
                
            }
            
            
        }
        
        
        
    }
    
    func getPercentage(){
        
    }
    
    func getSpent() -> Float{
        
        var spent : Float = 0.0
        for case let spendingCategory as SpendingCategory in self.budget.spendingCategories!{
            spent = spent + spendingCategory.limit
        }
        
        return spent
        
    }
    
    func calculateLeftToSpend(){
    
        let available = self.budget.getAmountAvailable()
        
        let spent = getSpent()
        
        self.leftToSpend = "$" + String(roundToTens(x: available) - roundToTens(x: spent))
        
    }
    
    func onKeyBoardSet(text: String, key: String?) {
        
        if key != nil && text != ""{
            let name = key!
            let value = Float(text)
            updateSpendingLimit(name: name, value: value!)
        }
        
        
    }
    
    func updateSpendingLimit(name: String, value: Float){
        
        for spendingCategory in self.budget.getSubSpendingCategories(){
            
            if spendingCategory.name! == name{
                spendingCategory.limit = value
            }
            
        }
        
        calculateLeftToSpend()
        generateViewData()
    }
    
    
    func roundToTens(x : Float) -> Int {
        return 10 * Int(round(x / 10.0))
    }
    
    func deleteCategory(name: String){
        self.budget.deSelectCategory(name: name)
        generateViewData()
        self.categoryPicker.generateViewData()
    }
    
    
    func incrementCategory(categoryName: String, incrementAmount: Int){
        
        for spendingCategory in self.budget.getSubSpendingCategories(){
            
            if spendingCategory.name! == categoryName{
                let newLimit = Int(spendingCategory.limit) + incrementAmount
                
                if newLimit >= 0{
                    print("decrementing the limit")
                    spendingCategory.limit = Float(newLimit)
                }
            }
            
        }
                

        //Update the View Data
        calculateLeftToSpend()
        generateViewData()
        
        

        
    }
    
}
