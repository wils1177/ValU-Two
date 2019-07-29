//
//  SetSavingsPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/23/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

struct SetSavingsViewData {
    
    var savingsTotal: String
    var incomeAmount: String
    var callToAction: String
    var savingsPercent : Float
    
}

class SetSavingsPresentor : Presentor {
    
    var budget : Budget
    var setSavingsVC : SetSavingsViewController?
    var coordinator : SetSavingsViewDelegate?
    
    
    init (budget : Budget){
        
        self.budget = budget
        
    }
    
    func configure() -> UIViewController {
        
        let viewData = generateViewData()
        self.setSavingsVC = SetSavingsViewController(viewData: viewData)
        self.setSavingsVC?.delagate = self
        
        return self.setSavingsVC!
    }
    
    func generateViewData() -> SetSavingsViewData{
        
        let savingsPercent = self.budget.getSavingsPercent()
        let savingsTotal = String(self.budget.calculateSavingsAmount(percentageOfAmount: savingsPercent))
        let incomeAmount = String(self.budget.getAmount()!)
        let callToAction  = "Continue"
        
        return SetSavingsViewData(savingsTotal: savingsTotal, incomeAmount: incomeAmount, callToAction: callToAction, savingsPercent: savingsPercent)
        
    }
    
    func sliderMoved(sliderVal : Float){
        let newSavingsAmount = self.budget.calculateSavingsAmount(percentageOfAmount: sliderVal)
        self.setSavingsVC?.savingsTotalLabel.text = String(newSavingsAmount)
    }
    
    func updateBudget(){
        
        let newPercent = self.setSavingsVC?.savingsSlider.value
        self.budget.setSavingsPercent(savingsPercent: newPercent!)
        
        self.coordinator?.savingsSubmitted(budget: self.budget, sender: self)
    }
}
