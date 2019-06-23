//
//  OnboardingFlowCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit



class OnboardingFlowCoordinator : Coordinator, StartPageViewDelegate, CreateBudgetPresentorDelegate{

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
        let newBudgetPresentor = CreateBudgetFormPresentor(budget: newBudget, callToActionMessage: "Continue")
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
        let setSavingVC = SetSavingsViewController()
        let ContainerVC = ContainerViewController(title: "Set a Savings Target", vc: setSavingVC)
        self.navigationController!.pushViewController(ContainerVC, animated: true)
    }
    
    
}
