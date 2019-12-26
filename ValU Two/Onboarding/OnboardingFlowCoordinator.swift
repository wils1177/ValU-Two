//
//  OnboardingFlowCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI




class OnboardingFlowCoordinator : Coordinator, StartPageViewDelegate, SetSavingsViewDelegate, PlaidLinkDelegate, BudgetCategoriesDelegate, SetSpendingLimitDelegate{

    // Dependencies
    var budgetToCreate : Budget?
    
    var childCoordinators = [Coordinator]()
    weak var parent: AppCoordinator?
    let navigationController : UINavigationController
    var currentPresentor : Presentor?
    
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController

    }
    
    func start(){
        print("onboarding flow started")
        var view = WelcomeView()
        view.coordinator = self
        let vc = UIHostingController(rootView: view)
        self.navigationController.navigationBar.prefersLargeTitles = true
        vc.title = "TESTING"
        vc.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: false)
        
    }
    
    func continueToOnboarding() {
        print("Contionue to onboarding")
        let newBudget = DataManager().createNewBudget()
        self.budgetToCreate = newBudget
        continueToPlaid()

    }
    
    func loadIncomeScreen(){

        let presentor = EnterIncomePresentor(budget: self.budgetToCreate!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func incomeSubmitted(budget: Budget, sender: EnterIncomePresentor) {
        
        if budget.isAmountEmpty(){
            print("Budget is empty!")
        }
        else{
            
            self.budgetToCreate = budget
            continueToSetSavings()
        }
    }
    
    func continueToSetSavings(){
        print("Contine to Set Savings Screen")
        let presentor = SetSavingsPresentor(budget: self.budgetToCreate!)
        presentor.coordinator = self
        self.currentPresentor = presentor
        let setSavingsVC = presentor.configure()
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(setSavingsVC, animated: true)
        setSavingsVC.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func savingsSubmitted(budget: Budget, sender: SetSavingsPresentor){
        self.budgetToCreate = budget
        continueToBudgetCategories()
        
    }
    
    func continueToBudgetCategories(){
        print("Contine to Budget Categories")
        let presentor = BudgetCardsPresentor(budget : self.budgetToCreate!)
        let vc = presentor.configure()
        presentor.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func categoriesSubmitted(){
        contionueToSetSpendingLimits()
    }
    
    func contionueToSetSpendingLimits(){
        print("Continue to Set Spending Limits")
        
        let presentor = SetSpendingPresentor(budget: self.budgetToCreate!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func finishedSettingLimits(){
        onboardingComplete()
    }
    
    func continueToPlaid(){
        var view = ConnectToBankView()
        view.coordinator = self
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    func launchPlaidLink(){
        let presentor = PlaidLinkViewPresentor(nibName: nil, bundle: nil)
        presentor.coordinator = self
        self.currentPresentor = presentor
        let linkVC = presentor.configure()
        linkVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(linkVC, animated: true)
        
    }
    
    func plaidLinkSuccess(sender: PlaidLinkViewPresentor){
        
        let presentor = LoadingAccountsPresentor()
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
            
        })
    }
    
    func plaidIsConnected(){
        loadIncomeScreen()
    }
    
    func onboardingComplete(){
        
        print("onboarding finished")
        
        self.parent?.currentBudget = self.budgetToCreate
        self.parent?.onboardingComplete(self)
        

        
        self.navigationController.dismiss(animated: true)
        

    }
    
    func dismissPlaidLink() {
        print("NOT IMPLEMENTED DISMISS ON PLAID LINK")
    }
    

    
    
}
