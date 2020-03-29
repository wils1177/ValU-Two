//
//  OnboardingSummaryPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

struct OnboardingSummaryViewData{
    var steps : [OnboardingStepViewData]
}

class OnboardingSummaryPresentor : Presentor, ObservableObject{
    
    var budget : Budget
    @Published var viewData : OnboardingSummaryViewData?
    var coordinator : OnboardingFlowCoordinator?
    var currentStep = 0
    
    
    init(budget: Budget){
        self.budget = budget
        generateViewData()
    }
    
    func configure() -> UIViewController {
        
        var view = OnboardingSummaryView(viewModel: self)
        view.coordinator = self.coordinator
        let vc = UIHostingController(rootView: view)
        return vc
        
        
    }
    
    func generateViewData(){
        
        self.currentStep = self.getCurrentStep()
        
        let connectBankStep = generateStep(currentStep: self.currentStep, title: "Connect to your bank", description: "A breif description", stage: 1)
        let enterIncomeStep = generateStep(currentStep: self.currentStep, title: "Enter your income", description: "A breif description", stage: 2)
        let savingsStep = generateStep(currentStep: self.currentStep, title: "Set a savings goal", description: "A breif description", stage: 3)
        let balanceStep = generateStep(currentStep: self.currentStep, title: "Balance your budget", description: "A breif description", stage: 4)
        
        let steps = [connectBankStep, enterIncomeStep, savingsStep, balanceStep]
        
        self.viewData = OnboardingSummaryViewData(steps: steps)
        
    }
    
    func generateStep(currentStep: Int, title: String, description: String, stage: Int) -> OnboardingStepViewData{
        
        let completed = currentStep >= stage
        let selectable = currentStep >= (stage - 1)
        let title = title
        let description = description
        let stageString = String(stage)
        let iconName = getIconName(stage: stageString, completed: completed)
        let iconColor = getIconColor(completed: completed)
        let backgroundColor = getBackgroundColor(selectable: selectable)
        var action : (()->Void)?
        if selectable{
            action = getAction(stage: stage)
        }
        else{
            action = nil
        }
        
        return OnboardingStepViewData(title: title, description: description, iconName: iconName, iconColor: iconColor, backgroundColor: backgroundColor, completionHandler: action)
        
    }
    
    
    func getCurrentStep() -> Int{
        
        var step = 0
        
        var itemCount = 0
        do {
            let items = try DataManager().getItems()
            itemCount = items.count
        }
        catch{
            print("Could not load items man")
        }
    
        if itemCount > 0 {
            step =  1
        }
        if self.budget.amount != Float(0.0){
            step = 2
        }
        if self.budget.savingsPercent != Float(0.0){
            step = 3
        }
        if self.budget.onboardingStatus == OnboardingStatus.completed.rawValue{
            step = 4
        }
        
        return step
    }
    
    func getIconName(stage: String, completed: Bool) -> String{
        
        if completed{
            return "checkmark.circle.fill"
        }
        else{
            return stage + ".circle.fill"
        }
    }
    
    func getAction(stage: Int) -> (()->Void)? {
        if stage == 1{
            return self.continueToPlaid
        }
        else if stage == 2{
            return self.loadIncomeScreen
        }
        else if stage == 3{
            return self.continueToSetSavings
        }
        else if stage == 4{
            return self.continueToBudgetCategories
        }
        else{
            return nil
        }
    }
    
    func getIconColor(completed: Bool) -> Color{
        
        if completed{
            return Color.green
        }
        else{
            return Color.white
        }
        
    }
    
    func getBackgroundColor(selectable: Bool) -> Color{
        if selectable{
            return Color.black
        }
        else{
            return Color.gray
        }
    }
    
    func continueToPlaid(){
        self.coordinator?.continueToPlaid()
    }
    
    func loadIncomeScreen(){
        self.coordinator?.loadIncomeScreen()
    }
    
    func continueToSetSavings(){
        self.coordinator?.continueToSetSavings()
    }
    
    func continueToBudgetCategories(){
        self.coordinator?.continueToBudgetCategories()
    }
    
    
    
    
}
