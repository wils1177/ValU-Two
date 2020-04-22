//
//  CreateBudgetViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//
import Foundation
import UIKit
import SwiftUI


class CreateBudgetViewModel : Presentor, NewBudgetModel, ObservableObject{
    
    
    @Published var currentStep: Int = 0
    
    @Published var viewData: OnboardingSummaryViewData?
    
    
    var budget : Budget
    var coordinator : NewBudgetCoordinator?
    
    init(budget: Budget){
        self.budget = budget
        generateViewData()
    }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: NewBudgetView(viewModel: self))
        return vc
    }
    
    func generateViewData(){
        
        self.currentStep = self.getCurrentStep()
        
        let enterIncomeStep = generateStep(currentStep: self.currentStep, title: "Enter your income", description: "A breif description", stage: 1)
        let savingsStep = generateStep(currentStep: self.currentStep, title: "Set a savings goal", description: "A breif description", stage: 2)
        let balanceStep = generateStep(currentStep: self.currentStep, title: "Balance your budget", description: "A breif description", stage: 3)
                
        
        let steps = [enterIncomeStep, savingsStep, balanceStep]
        
        self.viewData = OnboardingSummaryViewData(steps: steps)
        
    }
    
    func getAction(stage: Int) -> (()->Void)? {
        if stage == 1{
            return self.loadIncomeScreen
        }
        else if stage == 2{
            return self.continueToSetSavings
        }
        else if stage == 3{
            return self.continueToBudgetCategories
        }
        else{
            return nil
        }
    }
    
    func getCurrentStep() -> Int{
        
        var step = 0
        
    
        if self.budget.amount != Float(0.0){
            step = 1
        }
        if self.budget.savingsPercent != Float(0.0){
            step = 2
        }

        
        return step
    }
    
    func dismiss(){
        DataManager().saveDatabase()
        coordinator?.dimiss()
    }
    
    func cancel(){
        coordinator?.cancel()
    }
    
    func setType(){
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
