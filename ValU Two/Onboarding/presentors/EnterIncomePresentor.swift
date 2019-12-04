//
//  CreateBudgetFormPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class EnterIncomeViewData : ObservableObject {
    
    let timeFrameIndex : Int
    @Published var incomeAmountText : String
    
    init(timeFrameIndex: Int, incomeAmountText : String){
        self.incomeAmountText = incomeAmountText
        self.timeFrameIndex = timeFrameIndex
    }
    
    
    
}

class EnterIncomePresentor : Presentor {
    
    var viewController : UIViewController?
    var view : EnterIncomeView?
    var viewData : EnterIncomeViewData?
    let budget : Budget
    var coordinator : OnboardingFlowCoordinator?
    
    init(budget : Budget){
        self.budget = budget
    }
    
    func configure() -> UIViewController {
        self.viewData = createViewData(budget: self.budget)
        self.view = EnterIncomeView(presentor: self, viewData: viewData!)
        let vc = UIHostingController(rootView: self.view)
        self.viewController = vc
        return self.viewController!
    }
    
    func createViewData(budget: Budget) -> EnterIncomeViewData{
        
        let timeFrameIndex : Int?
        if budget.timeFrame == TimeFrame.monthly.rawValue{
            timeFrameIndex = 0
        }
        else{
            timeFrameIndex = 1
        }
        
        let incomeAmount = budget.amount
        
        var incomeAmountText  = ""
        if incomeAmount != 0.0{
            incomeAmountText =  String(describing: incomeAmount)
        }

        
        
        return EnterIncomeViewData(timeFrameIndex: timeFrameIndex!, incomeAmountText: incomeAmountText)
    }
    
    func userSelectedCTA(){
        if self.viewData!.incomeAmountText != ""{
            let budget = viewDataToBudget(viewData: self.viewData!)
            print("Printing Budget Amount made")
            print(budget.amount)
            self.coordinator?.incomeSubmitted(budget: budget, sender: self)
        }
        
    }
    
    func viewDataToBudget(viewData: EnterIncomeViewData) -> Budget{
        
        
        self.budget.setTimeFrame(timeFrame: TimeFrame.monthly)
        
        let amount = Float(viewData.incomeAmountText)
        
        self.budget.amount = amount!
        self.budget.active = true
        
        return self.budget
    }
    
    //func enterErroState(){
    //    self.budgetFormVC?.enterErrorState()
    //}
    
    
}
