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

class OnboardingSummaryPresentor : Presentor, NewBudgetModel, ObservableObject{
    
    var coordinator: BudgetEditableCoordinator?
    @Published var itemManagerService : ItemManagerService
    
    
    var budget : Budget
    @Published var viewData : OnboardingSummaryViewData?
    var currentStep = 0
    
    
    init(budget: Budget, itemManagerService: ItemManagerService){
        self.budget = budget
        self.itemManagerService = itemManagerService
        generateViewData()
    }
    
    func configure() -> UIViewController {
        
        let view = OnboardingSummaryView(viewModel: self)
            .environmentObject(self.itemManagerService)
        
        let vc = UIHostingController(rootView: view)
        return vc
        
        
    }
    
    func generateViewData(){
        
        self.currentStep = self.getCurrentStep()
        
        let connectBankStep = generateStep(currentStep: self.currentStep, title: "Connect to your bank", description: getBankDescription(), stage: 1)
        let enterIncomeStep = generateStep(currentStep: self.currentStep, title: "Confirm your income", description: "Set your income for your budget", stage: 2)
        let savingsStep = generateStep(currentStep: self.currentStep, title: "Set a savings goal", description: "Decide how much you want to save", stage: 3)
        let balanceStep = generateStep(currentStep: self.currentStep, title: "Create your budget", description: "Make your budgets!", stage: 4)
        
        let steps = [connectBankStep, enterIncomeStep, savingsStep, balanceStep]
        
        self.viewData = OnboardingSummaryViewData(steps: steps)
        
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
    
    func continueToPlaid(){
        self.coordinator?.continueToPlaid()
        
        
    }
    
    func loadIncomeScreen(){
        self.coordinator?.continueToTimeFrame()
        
    }
    
    func continueToSetSavings(){
        self.coordinator?.continueToSetSavings()
        
    }
    
    func continueToBudgetCategories(){
        self.coordinator?.continueToBudgetCategories()
        
        
    }
    

    
    
    
    
}

extension NewBudgetModel{
    
    func generateStep(currentStep: Int, title: String, description: String, stage: Int) -> OnboardingStepViewData{
        
        let completed = currentStep >= stage
        let selectable = currentStep >= (stage - 1)
        let title = title
        let description = description
        let stageString = String(stage)
        let iconName = getIconName(stage: stageString, completed: completed)
        let iconColor = getIconColor(selectable: selectable)
        let backgroundColor = getBackgroundColor(selectable: selectable)
        let subTextColor = getSubTextColor(selectable: selectable)
        var action : (()->Void)?
        if selectable{
            action = getAction(stage: stage)
        }
        else{
            action = nil
        }
        
        return OnboardingStepViewData(title: title, description: description, iconName: iconName, iconColor: iconColor, backgroundColor: backgroundColor, subTectColor: subTextColor, completionHandler: action)
        
    }
    
    func getItemCount() -> Int{
        var itemCount = 0
        do {
            let items = try DataManager().getItems()
            itemCount = items.count
        }
        catch{
            print("Could not load items man")
        }
        return itemCount
    }
    
    func getBankDescription() -> String{
        let itemCount = getItemCount()
        if itemCount == 0 {
            return "Set up an automated connection"
        }
        else if itemCount == 1{
            return String(itemCount) + " account connected"
        }
        else{
            return String(itemCount) + " accounts connected"
        }
        
    }
    
    
    func getCurrentStep() -> Int{
        
        var step = 0
        
        let itemCount = getItemCount()
    
        if itemCount > 0 {
            step =  1
        }
        if self.budget.amount != Float(0.0){
            step = 2
        }
        if self.budget.savingsPercent != Float(0.0){
            step = 3
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
    
    
    
    func getIconColor(selectable: Bool) -> Color{
        
        if selectable{
            return AppTheme().themeColorPrimary
        }
        else{
            return Color(.lightGray)
        }
        
    }
    
    func getBackgroundColor(selectable: Bool) -> Color{
        if selectable{
            return Color(.black)
        }
        else{
            return Color(.lightGray)
        }
    }
    
    func getSubTextColor(selectable: Bool) -> Color{
        if selectable{
            return Color(.gray)
        }
        else{
            return Color(.lightGray)
        }
    }
    

    
}
