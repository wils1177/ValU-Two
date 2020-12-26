//
//  SetSavingsPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/23/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class SetSavingsViewData : ObservableObject {
    
    @Published var savingsAmount : String
    @Published var spendingAmount : String
    @Published var savingsPercentage : Float
    
    init(savingsAmount: String, spendingAmount : String, savingsPercentage: Float){
        self.savingsAmount =  savingsAmount
        self.spendingAmount = spendingAmount
        self.savingsPercentage = savingsPercentage
    }
    
    
    
}

class SetSavingsPresentor : Presentor {
    
    var budget : Budget
    var setSavingsVC : UIViewController?
    var coordinator : SetSavingsViewDelegate?
    var viewData : SetSavingsViewData?
    var roundingLevel : Int
    
    
    init (budget : Budget){
        
        self.budget = budget
        self.roundingLevel = SetSavingsPresentor.getRoundingLevel(amount: self.budget.amount)
        
        if self.budget.savingsPercent == Float(0.0){
            self.budget.savingsPercent = 0.5
        }
        
    }
    
    func configure() -> UIViewController {
        
        var viewData = generateViewData()
        self.viewData = viewData
        self.setSavingsVC = UIHostingController(rootView: SetSavingsView(presentor: self, viewData: viewData))
        self.setSavingsVC?.navigationController?.setNavigationBarHidden(true, animated: false)
        return self.setSavingsVC!
    }
    
    func generateViewData() -> SetSavingsViewData{
        
        let amount = Float(self.budget.amount)
        let percentage = self.budget.savingsPercent
        
        let spendingAmount = Int(amount * (1-percentage))
        let savingsAmount = Int(amount * percentage)
        
        let spendingAmountText = String(spendingAmount)
        let savingsAmountText = String(savingsAmount)
        
        let viewData = SetSavingsViewData(savingsAmount: savingsAmountText, spendingAmount: spendingAmountText, savingsPercentage: percentage)
        
        
        return viewData
    }
    
    static func getRoundingLevel(amount: Float) -> Int{
        if amount <= 100{
            return 1
        }
        else if amount > 100 && amount <= 2000{
            return 10
        }
        else{
            return 50
        }
    }
    
    func sliderMoved(sliderVal : Float){
        
        if !(sliderVal >= 0.9 || sliderVal <= 0.1){
            self.budget.savingsPercent = sliderVal
            
            let newViewData = generateViewData()
            
            self.viewData?.savingsAmount = newViewData.savingsAmount
            self.viewData?.spendingAmount = newViewData.spendingAmount
            self.viewData?.savingsPercentage = newViewData.savingsPercentage
        }
        
        
    }
    
    
    func assignNewSavingsPercent(val: Float){
        
        let income = self.budget.amount
        let rawIntendedSavingsAmount = income * val
        let roundedSavingsAmount = roundToLevel(x: rawIntendedSavingsAmount, level: self.roundingLevel)
        let roundedSavingsPercent = Float(roundedSavingsAmount) / income
        
        self.budget.savingsPercent = roundedSavingsPercent
        
    }
    
    
    
    
    
    
    

    
    func userPressedContinue(){
        self.coordinator?.savingsSubmitted(budget: self.budget, sender: self)
    }
    
    
    func roundToLevel(x : Float, level: Int) -> Int {
        return level * Int(round(x / Float(level)))
    }
    
}
