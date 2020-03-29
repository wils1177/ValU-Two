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
    
    
    init (budget : Budget){
        
        self.budget = budget
        
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
        
        let spendingAmount = amount * (1-percentage)
        let savingsAmount = amount * percentage
        
        let roundedSpendingAmount = roundToTens(x: spendingAmount)
        let roundedSavingsAmount = roundToTens(x: savingsAmount)
        
        let spendingAmountText = String(roundedSpendingAmount)
        let savingsAmountText = String(roundedSavingsAmount)
        
        let viewData = SetSavingsViewData(savingsAmount: savingsAmountText, spendingAmount: spendingAmountText, savingsPercentage: percentage)
        
        
        return viewData
    }
    
    func sliderMoved(sliderVal : Float){
        self.budget.savingsPercent = sliderVal
        
        let newViewData = generateViewData()
        
        self.viewData?.savingsAmount = newViewData.savingsAmount
        self.viewData?.spendingAmount = newViewData.spendingAmount
        self.viewData?.savingsPercentage = newViewData.savingsPercentage
    }
    

    
    func userPressedContinue(){
        self.coordinator?.savingsSubmitted(budget: self.budget, sender: self)
    }
    
    
    func roundToTens(x : Float) -> Int {
        return 10 * Int(round(x / 10.0))
    }
    
}
