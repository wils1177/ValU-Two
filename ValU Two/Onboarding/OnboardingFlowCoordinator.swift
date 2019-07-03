//
//  OnboardingFlowCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit



class OnboardingFlowCoordinator : Coordinator, StartPageViewDelegate, CreateBudgetPresentorDelegate, SetSavingsViewDelegate, PlaidLinkDelegate{

    // Dependencies
    var budgetToCreate : Budget?
    
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
        let newBudgetPresentor = CreateBudgetFormPresentor(budget: newBudget, callToActionMessage: "testing 123")
        self.currentPresentor = newBudgetPresentor
        newBudgetPresentor.coordinator = self
        let NewBudgetVC = self.currentPresentor?.configure()
        let ContainerVC = ContainerViewController(title: "Create a Budget", vc: NewBudgetVC!)
        self.navigationController!.pushViewController(ContainerVC, animated: true)
    }
    
    func budgetSubmitted(budget: Budget, sender: CreateBudgetFormPresentor) {
        
        if budget.isAmountEmpty(){
            print("heyo")
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
        temp_launch_plaid()
        
    }
    
    // This is just a temporary function to play with the Plaid functionality. 
    func temp_launch_plaid(){
        print("hey dude")
        let presentor = PlaidLinkViewPresentor(nibName: nil, bundle: nil)
        self.currentPresentor = presentor
        let linkVC = presentor.configure()
        self.navigationController!.present(linkVC, animated: true)
        
    }
    
    func dismissPlaidLink() {
        print("no")
    }
    
    
}
