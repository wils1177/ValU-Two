//
//  EditViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct EditBudgetViewData{
    var steps : [OnboardingStepViewData]
    var navigationTitle : String
    var description : String
}

class EditBudgetViewModel : Presentor, BudgetEditor{    
    
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
        let editIncome = OnboardingStepViewData(title: "Edit Income", description: "A breif description", iconName: "pencil.circle.fill", iconColor: Color(.white), backgroundColor: Color(.black), completionHandler: self.editIncome)
        let editSavings = OnboardingStepViewData(title: "Edit Savings Goal", description: "A breif description", iconName: "pencil.circle.fill", iconColor: Color(.white), backgroundColor: Color(.black), completionHandler: self.editSavings)
        let editBudget = OnboardingStepViewData(title: "Rebalance Budget", description: "A breif description", iconName: "pencil.circle.fill", iconColor: Color(.white), backgroundColor: Color(.black), completionHandler: self.editBudget)
        
        let steps = [editIncome, editSavings, editBudget]
        
        let navigationTitle = "Edit Budget"
        let description = "Select an option to begin editing your budget."
        
        self.viewData = EditBudgetViewData(steps: steps, navigationTitle: navigationTitle, description: description)
        
    }
    
    
}

extension BudgetEditor{
    
    func editIncome(){
        coordinator?.loadIncomeScreen()
    }
    
    func editBudget(){
        coordinator?.editBudgetCategories()
    }
    
    func editSavings(){
        coordinator?.continueToSetSavings()
    }
    
    func dismiss(){
        coordinator?.dimiss()
    }
    

}
