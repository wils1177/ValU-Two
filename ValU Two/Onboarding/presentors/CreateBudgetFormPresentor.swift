//
//  CreateBudgetFormPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

struct CreateBudgetFormViewRep {
    
    let timeFrameIndex : Int
    let incomeAmountText : String
    let callToActionMessage : String
    
}

class CreateBudgetFormPresentor : Presentor, CreateBudgetVCDelegate {
    
    var budgetFormVC : CreateBudgetFormViewController?
    let budget : Budget
    let callToActionMessage : String
    var coordinator : CreateBudgetPresentorDelegate?
    
    init(budget : Budget, callToActionMessage: String){
        self.budget = budget
        self.callToActionMessage = callToActionMessage
    }
    
    func configure() -> UIViewController {
        let viewData = createViewData(budget: self.budget, callToActoinMessage: self.callToActionMessage)
        let vc = CreateBudgetFormViewController(viewData: viewData)
        vc.delegate = self
        self.budgetFormVC = vc
        return self.budgetFormVC!
    }
    
    func createViewData(budget: Budget, callToActoinMessage: String) ->CreateBudgetFormViewRep{
        
        let timeFrameIndex : Int?
        if budget.timeFrame == TimeFrame.monthly.rawValue{
            timeFrameIndex = 0
        }
        else{
            timeFrameIndex = 1
        }
        
        let incomeAmount = budget.amount
        let incomeAmountText =  String(describing: incomeAmount)
        
        
        return CreateBudgetFormViewRep(timeFrameIndex: timeFrameIndex!, incomeAmountText: incomeAmountText, callToActionMessage: callToActoinMessage)
    }
    
    func userSelectedCTA(viewData: CreateBudgetFormViewRep){
        let budget = viewDataToBudget(viewData: viewData)
        self.coordinator?.budgetSubmitted(budget: budget, sender: self)
    }
    
    func viewDataToBudget(viewData: CreateBudgetFormViewRep) -> Budget{
        
        if viewData.timeFrameIndex == 0{
            self.budget.setTimeFrame(timeFrame: TimeFrame.monthly)
        }
        else{
            self.budget.setTimeFrame(timeFrame: TimeFrame.semiMonthly)
        }
        
        let amount = Float(viewData.incomeAmountText)
        
        self.budget.amount = amount!
        self.budget.active = true
        
        return self.budget
    }
    
    func enterErroState(){
        self.budgetFormVC?.enterErrorState()
    }
    
    
}
