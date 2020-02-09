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

enum LoadingIncomeViewState{
    case Loading
    case Success
    case Failure
    case Initial
}

class IncomeStreamViewData : Hashable{
    let name : String
    let monthlyAmount: String
    
    init(name: String, monthlyAmount : String){
        self.name = name
        self.monthlyAmount = monthlyAmount
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(monthlyAmount)

    }
    
    static func == (lhs: IncomeStreamViewData, rhs: IncomeStreamViewData) -> Bool {
        return lhs.name == rhs.name && lhs.monthlyAmount == rhs.monthlyAmount
    }
}

class EnterIncomeViewData : ObservableObject {
    
    let timeFrameIndex : Int
    var incomeStreams = [IncomeStreamViewData]()
    @Published var incomeAmountText : String
    @Published var viewState = LoadingIncomeViewState.Initial
    
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
    let plaid  = PlaidConnection()
    let dataManager = DataManager()
    
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
    
    func userRequestedIncome(){
        
        //Set the view to be in the loading state
        self.viewData?.viewState = LoadingIncomeViewState.Loading
        
        // Only setting up one notification observer for the webhook
        // TODO: This will be refactored once we support multiple items
       // NotificationCenter.default.addObserver(self, selector: #selector(recievedIncomeWebhook(_:)), name: .incomeReady, object: nil)
        
        do{
            //Get all the items we might want to check for income streams
            let items = try dataManager.getItems()
            
            //for item in items{
                
                //Check if we've already gotten the PRODUCT_READY webhook
                //let itemId = item.itemId ?? ""
                //let incomeItemKey = PlaidUserDefaultKeys.incomeReadyKey.rawValue + itemId
                //print(incomeItemKey)
                //if UserDefaults.standard.object(forKey: incomeItemKey) as! Bool == true{
               //     startIncomePull()
               // }
                
            //}
        }
        //If something goes wrong, we change the view to the failure state
        catch{
            self.viewData?.viewState = LoadingIncomeViewState.Failure
        }
        
        
    }
    
    func viewDataToBudget(viewData: EnterIncomeViewData) -> Budget{
        
        let amount = Float(viewData.incomeAmountText)
        
        self.budget.amount = amount!
        self.budget.active = true
        
        return self.budget
    }
    
    

    
    
    
    /*
    func displayIncomeStreams(){
        
        do{
            // Collect all the income streams and display them
            let incomes = try dataManager.getIncomeData()
            
            for income in incomes{
                for case let incomeStream as IncomeStreamData in income.incomeStreams ?? NSSet() {
                    let incomeStreamViewData = IncomeStreamViewData(name: incomeStream.name ?? "IncomeStream", monthlyAmount: String(incomeStream.monthlyIncome))
                    self.viewData?.incomeStreams.append(incomeStreamViewData)
                }
            }
            
            self.viewData?.viewState = LoadingIncomeViewState.Success
            
        }
        //If something goes wrong, we change the view to the failure state
        catch{
            self.viewData?.viewState = LoadingIncomeViewState.Failure
        }
        
        
        
        
    }
 */
    
    
}
