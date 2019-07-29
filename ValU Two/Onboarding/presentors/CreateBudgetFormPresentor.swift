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
        if budget.getTimeFrame() == timeFrame.monthly{
            timeFrameIndex = 0
        }
        else{
            timeFrameIndex = 1
        }
        
        let incomeAmountText : String?
        if let incomeAmount = budget.getAmount(){
            incomeAmountText =  String(describing: incomeAmount)
        } else{
            incomeAmountText =  ""
        }
        
        
        return CreateBudgetFormViewRep(timeFrameIndex: timeFrameIndex!, incomeAmountText: incomeAmountText!, callToActionMessage: callToActoinMessage)
    }
    
    func userSelectedCTA(viewData: CreateBudgetFormViewRep){
        let budget = viewDataToBudget(viewData: viewData)
        self.coordinator?.budgetSubmitted(budget: budget, sender: self)
    }
    
    func viewDataToBudget(viewData: CreateBudgetFormViewRep) -> Budget{
        
        let budgetTimeFrame : timeFrame
        if viewData.timeFrameIndex == 0{
            budgetTimeFrame = timeFrame.monthly
        }
        else{
            budgetTimeFrame = timeFrame.semiMonthly
        }
        
        let amount = Float(viewData.incomeAmountText)
        
        return Budget(amount: amount, budgetTimeFrame: budgetTimeFrame)
    }
    
    func enterErroState(){
        self.budgetFormVC?.enterErrorState()
    }
    
    
}
