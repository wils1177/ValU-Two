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
    
    var coordinator: NewBudgetCoordinator?
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
        
        let timeFrameStep = generateStep(currentStep: self.currentStep, title: "Select Time Frame", description: getTimeFrameDescription(), stage: 1)
        let enterIncomeStep = generateStep(currentStep: self.currentStep, title: "Enter Your Income", description: getIncomeDescription(), stage: 2)
        let savingsStep = generateStep(currentStep: self.currentStep, title: "Set a Savings Goal", description: getSavingsDescription(), stage: 3)
        let balanceStep = generateStep(currentStep: self.currentStep, title: "Create Your Budget", description: getBudgetsDescription(), stage: 4)
        
        let steps = [timeFrameStep, enterIncomeStep, savingsStep, balanceStep]
        
        self.viewData = OnboardingSummaryViewData(steps: steps)
        
    }
    
    func getAction(stage: Int) -> (()->Void)? {

        if stage == 1{
            return self.continueToTimeFrame
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
        self.coordinator?.loadIncomeScreen()
        
    }
    
    func continueToSetSavings(){
        self.coordinator?.continueToSetSavings()
        
    }
    
    func continueToBudgetCategories(){
        self.coordinator?.continueToBudgetCategories()
        
        
    }
    
    func continueToTimeFrame(){
        self.coordinator?.continueToTimeFrame()
    }
    
    func dismiss(){
        self.coordinator?.dimiss()
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
    
    func getTimeFrameDescription() -> String{
        
        if self.budget.timeFrame == 0{
            return "Monthly Budget"
        }
        else if self.budget.timeFrame == 1{
            return "Sem-Monthly Budget"
        
        }
        else if self.budget.timeFrame == 2{
            return "Weekly Budget"
        }
        else{
            return "How long is your budget?"
        }
        
    }
    
    func getIncomeDescription() -> String{
        if self.budget.amount == Float(0.0){
            return "Set your income for your budget"
        }
        else {
            return CommonUtils.makeMoneyString(number: Int(self.budget.amount))
        }
    }
    
    func getSavingsDescription() -> String{
        if self.budget.savingsPercent == Float(0.0){
            return "Set a savings goal"
        }
        else {
            return String(Int(self.budget.savingsPercent * 100)) + "%"   + " of income"
        }
    }
    
    func getBudgetsDescription() -> String{
        
        if self.budget.getAmountLimited() == Float(0.0){
            return "Setup your Budgets"
        }
        else{
            let moneystring = CommonUtils.makeMoneyString(number: Int(self.budget.getAmountLimited()))
            return (moneystring + " budgeted")
        }
        
    }
    
    
    func getCurrentStep() -> Int{
        
        var step = 0
        
        if self.budget.timeFrame != -1{
            step = 1
        }

        if self.budget.amount != Float(0.0){
            step = 2
        }
        if self.budget.savingsPercent != Float(0.0){
            step = 3
        }
        if self.budget.getAmountLimited() > Float(0.0){
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
