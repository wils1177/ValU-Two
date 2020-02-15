//
//  SetSpendingPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/6/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ViewCategory : ObservableObject, Hashable {

    var name : String
    var lastThirtyDaysSpent : String
    @Published var limit : String
    
    init(name: String, limit: String, lastThirtyDaysSpent: String) {
        self.name = name
        self.limit = limit
        self.lastThirtyDaysSpent = lastThirtyDaysSpent
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)

    }
    
    static func == (lhs: ViewCategory, rhs: ViewCategory) -> Bool {
        return lhs.name == rhs.name && lhs.limit == rhs.limit
    }
}

class SetLimitsViewData : ObservableObject{
    
    @Published var leftToSpend : String
    var categoryPercentages : [ViewCategory]
    
    init(leftToSpend : String, categoryPercentages : [ViewCategory]){
        self.leftToSpend = leftToSpend
        self.categoryPercentages = categoryPercentages
    }
    
}

class SetSpendingPresentor : Presentor {
    
    
    var viewData : SetLimitsViewData?
    let budget : Budget
    var coordinator : OnboardingFlowCoordinator?
    
    init(budget : Budget){
        self.budget = budget
        self.viewData = generateViewData()
    }
    
    func configure() -> UIViewController {
        
        let vc = UIHostingController(rootView: SetLimitsView(presentor: self, viewData: self.viewData!))
        return vc
    }
    
    
    func submit() {
        self.coordinator?.finishedSettingLimits()
    }
    
    func generateViewData() -> SetLimitsViewData{
        
        
        var categoryPercentages = [ViewCategory]()
        for spendingCategory in self.budget.getSubSpendingCategories(){
            if spendingCategory.selected{
                let name = spendingCategory.name
                let lastThirtyDaysSpent = spendingCategory.initialThirtyDaysSpent
                let viewCategory = ViewCategory(name : name!, limit: String(roundToTens(x: spendingCategory.limit)), lastThirtyDaysSpent: String(lastThirtyDaysSpent))
                categoryPercentages.append(viewCategory)
            }
            
            
        }
        
        let leftToSpend = calculateLeftToSpend()
        
        return SetLimitsViewData(leftToSpend: String(leftToSpend), categoryPercentages: categoryPercentages)
        
    }
    
    func calculateLeftToSpend() -> Int{
    
        let available = self.budget.getAmountAvailable()
        
        var spent : Float = 0.0
        for case let spendingCategory as SpendingCategory in self.budget.spendingCategories!{
            spent = spent + spendingCategory.limit
        }
        
        let leftToSpend = roundToTens(x: available) - roundToTens(x: spent)
        return leftToSpend
    }
    
    
    func textFieldChanged(categoryName: String, newValue: String){
        //TODO: Actually write this function ):
    }
    
    
    func incrementCategory(categoryName: String, incrementAmount: Int){
        
        let available = Int(self.budget.getAmountAvailable())
        print("ayy")
        //First, we check to see if check to see if there is money left to spend
        if (Int(self.viewData!.leftToSpend)! - incrementAmount) >= 0{
            
            // Save the new budget limit
            for spendingCategory in self.budget.getSubSpendingCategories(){
            
                if spendingCategory.selected{
                    if spendingCategory.name == categoryName{
                        let newLimit = Int(spendingCategory.limit) + incrementAmount
                        
                        if newLimit >= 0{
                            print("decrementing the limit")
                            spendingCategory.limit = Float(newLimit)
                        }
                        
                    }
                }
                
                
            }
            
            //Update the View Data
            self.viewData?.leftToSpend = String(calculateLeftToSpend())
            
            for category in self.viewData!.categoryPercentages{
                if category.name == categoryName{
                    let newLimit = Int(category.limit)! + incrementAmount
                    if newLimit >= 0 {
                        category.limit = String(Int(category.limit)! + incrementAmount)
                    }
                    
                }
            }
            
        }
        else{
            print("you can't increment a category like that!!")
        }
        
        

        
    }
      
    
    func roundToTens(x : Float) -> Int {
        return 10 * Int(round(x / 10.0))
    }
    
    
    
    
    
    
}


