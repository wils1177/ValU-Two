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


class CreateBudgetViewModel : Presentor, BudgetEditor{
    
    var budget : Budget
    var viewData : EditBudgetViewData?
    var coordinator : BudgetEditableCoordinator?
    
    init(budget: Budget){
        self.budget = budget
        generateViewData()
    }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: EditOverView(viewModel: self))
        return vc
    }
    
    func generateViewData(){
        let setMonth = OnboardingStepViewData(title: "Set Month", description: "Set month for budget", iconName: "1.circle.fill", iconColor: Color(.white), backgroundColor: Color(.black), completionHandler: self.setMonth)
        let editIncome = OnboardingStepViewData(title: "Set Income", description: "A breif description", iconName: "2.circle.fill", iconColor: Color(.white), backgroundColor: Color(.black), completionHandler: self.editIncome)
        let editSavings = OnboardingStepViewData(title: "Set Savings Goal", description: "A breif description", iconName: "3.circle.fill", iconColor: Color(.white), backgroundColor: Color(.black), completionHandler: self.editSavings)
        
        let editBudget = OnboardingStepViewData(title: "Balance Budget", description: "A breif description", iconName: "4.circle.fill", iconColor: Color(.white), backgroundColor: Color(.black), completionHandler: self.editBudget)
        
        let steps = [setMonth, editIncome, editSavings, editBudget]
        
        let navigationTitle = "New Budget"
        let description = "Select an option to begin editing your budget."
        
        self.viewData = EditBudgetViewData(steps: steps, navigationTitle: navigationTitle, description: description)
        
    }
    
    func dismiss(){
        DataManager().saveDatabase()
        coordinator?.dimiss()
    }
    
    func setMonth(){
        coordinator?.setMonth()
    }
    
    
    
    
}
