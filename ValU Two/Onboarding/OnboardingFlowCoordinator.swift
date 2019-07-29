//
//  OnboardingFlowCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit



class OnboardingFlowCoordinator : Coordinator, StartPageViewDelegate, CreateBudgetPresentorDelegate, SetSavingsViewDelegate, PlaidLinkDelegate, BudgetCategoriesDelegate, SetSpendingLimitDelegate{

    // Dependencies
    var budgetToCreate : Budget?
    var accounts : [Account]?
    
    var childCoordinators = [Coordinator]()
    weak var parent: AppCoordinator?
    let navigationController : UINavigationController?
    var currentPresentor : Presentor?
    
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start(){
        print("onboarding flow started")
        let vc = StartPageViewController(nibName: "StartPageViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: false)
        vc.coordinator = self
    }
    
    func continueToOnboarding() {
        print("Contionue onto onboarding")
        let newBudget = Budget()
        let newBudgetPresentor = CreateBudgetFormPresentor(budget: newBudget, callToActionMessage: "Continue")
        self.currentPresentor = newBudgetPresentor
        newBudgetPresentor.coordinator = self
        let NewBudgetVC = self.currentPresentor?.configure()
        let ContainerVC = ContainerViewController(title: "Create a Budget", vc: NewBudgetVC!)
        self.navigationController!.pushViewController(ContainerVC, animated: true)
    }
    
    func budgetSubmitted(budget: Budget, sender: CreateBudgetFormPresentor) {
        
        if budget.isAmountEmpty(){
            sender.enterErroState()
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
        let ContainerVC = ContainerViewController(title: "Set a Savings Target", vc: setSavingsVC)
        self.navigationController!.pushViewController(ContainerVC, animated: true)
    }
    
    func savingsSubmitted(budget: Budget, sender: SetSavingsPresentor){
        self.budgetToCreate = budget
        continueToBudgetCategories()
        
    }
    
    func continueToBudgetCategories(){
        print("Contine to Budget Categories")
        let presentor = BudgetCardsPresentor(budget : self.budgetToCreate!)
        presentor.coordinator = self
        let vc = presentor.configure()
        let ContainerVC = ContainerViewController(title: "Select your budget categories", vc: vc)
        self.navigationController!.pushViewController(ContainerVC, animated: true)
    }
    
    func categoriesSubmitted(){
        contionueToSetSpendingLimits()
    }
    
    func contionueToSetSpendingLimits(){
        print("Continue to Set Spending Limits")
        let vc = SetSpendingLimitViewController(budget: self.budgetToCreate!)
        vc.coordinator = self
        let ContainerVC = ContainerViewController(title: "Set spending limits", vc: vc)
        self.navigationController!.pushViewController(ContainerVC, animated: true)
    }
    
    func finishedSettingLimits(){
        continueToPlaid()
    }
    
    func continueToPlaid(){
        let vc = PlaidViewController()
        vc.coordinator = self
        self.navigationController!.pushViewController(vc, animated: true)
    }
    

    func launchPlaidLink(){
        let presentor = PlaidLinkViewPresentor(nibName: nil, bundle: nil)
        presentor.coordinator = self
        self.currentPresentor = presentor
        let linkVC = presentor.configure()
        self.navigationController!.present(linkVC, animated: true)
        
    }
    
    func plaidLinkSuccess(accounts : [Account], sender: PlaidLinkViewPresentor){
        
        self.accounts = accounts
        let presentor = LoadingAccountsPresentor(accounts: self.accounts!)
        let vc = presentor.configure()
        
        self.navigationController!.pushViewController(vc, animated: true)
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
            
        })
    }
    
    func dismissPlaidLink() {
        print("NOT IMPLEMENTED DISMISS ON PLAID LINK")
    }
    
    
    //func continueToAccountsPage(){
    //    let presentor = SelectAccountsPresentor(accounts : self.accounts!)
        //presentor.coordinator = self
     //   let vc = presentor.configure()
   //     let ContainerVC = ContainerViewController(title: "Select your Accounts", vc: vc)
    //    self.navigationController!.pushViewController(ContainerVC, animated: true)
        
  //  }
    
    
}
