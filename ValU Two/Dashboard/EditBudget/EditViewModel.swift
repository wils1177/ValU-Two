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
    var coordinator : BudgetEditableCoordinator?
    
    init(budget: Budget){
        self.budget = budget
   }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: EditOverView(viewModel: self))
        return vc
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
    

    
    
}

extension BudgetEditor{
    
    func editTimeFrame(){
        coordinator?.continueToTimeFrame()
    }
    
    func editIncome(){
        coordinator?.loadIncomeScreen()
    }
    
    func editBudget(){
        coordinator?.continueToBudgetCategories()
    }
    
    func editSavings(){
        coordinator?.continueToSetSavings()
    }
    
    func editType(){
        coordinator?.continueToBudgetType()
    }
    
    func dismiss(){
        coordinator?.dimiss()
    }
    

}
