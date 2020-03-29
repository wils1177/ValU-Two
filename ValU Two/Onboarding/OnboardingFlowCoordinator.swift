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




class OnboardingFlowCoordinator : Coordinator, StartPageViewDelegate, SetSavingsViewDelegate, PlaidLinkDelegate, BudgetCategoriesDelegate, SetSpendingLimitDelegate, plaidIsConnectedDelegate, IncomeCoordinator{
    

    // Dependencies
    var budget : Budget?
    
    var childCoordinators = [Coordinator]()
    weak var parent: AppCoordinator?
    var navigationController : UINavigationController
    var onboardingSummaryPresentor : OnboardingSummaryPresentor?
    var currentPresentor : Presentor?
    
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController

    }
    
    func start(){
        
        
        
        print("onboarding flow started")
        
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        
        let existingBudget = try? DataManager().getBudget()
        if existingBudget == nil{
            self.budget = DataManager().createNewBudget()
            self.budget?.active = true
            var view = WelcomeView()
            view.coordinator = self
            let vc = UIHostingController(rootView: view)
            vc.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController.pushViewController(vc, animated: false)
        }
        else{
            self.budget = existingBudget
            self.onboardingSummaryPresentor = OnboardingSummaryPresentor(budget: self.budget!)
            self.onboardingSummaryPresentor!.coordinator = self
            let vc = self.onboardingSummaryPresentor!.configure()
            self.navigationController.pushViewController(vc, animated: false)
        }
        
        
        
    }
    
    func continueToOnboarding() {
        print("Contionue to onboarding")
        
        
        showSummary()

    }
    
    func showSummary(){
        self.onboardingSummaryPresentor = OnboardingSummaryPresentor(budget: self.budget!)
        self.onboardingSummaryPresentor!.coordinator = self
        let vc = self.onboardingSummaryPresentor!.configure()
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    

    
    func continueToSetSavings(){
        print("Contine to Set Savings Screen")
        let presentor = SetSavingsPresentor(budget: self.budget!)
        presentor.coordinator = self
        self.currentPresentor = presentor
        let setSavingsVC = presentor.configure()
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(setSavingsVC, animated: true)
        setSavingsVC.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func savingsSubmitted(budget: Budget, sender: SetSavingsPresentor){
        self.budget = budget
        self.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
        
    }
    
    func continueToBudgetCategories(){
        print("Contine to Budget Categories")
        
        let presentor = BudgetBalancerPresentor(budget: self.budget!)
        let vc = presentor.configure()
        presentor.coordinator = self
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func loadIncomeScreen(){

        let presentor = EnterIncomePresentor(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    func incomeSubmitted(budget: Budget, sender: EnterIncomePresentor) {
        
        self.budget = budget
        self.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    
    }

    
    func categoriesSubmitted(){
        contionueToSetSpendingLimits()
    }
    
    func contionueToSetSpendingLimits(){
        print("Continue to Set Spending Limits")
        
        let presentor = SetSpendingPresentor(budget: self.budget!)
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
        
        let presentor = LoadingAccountsPresentor(budget : self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
            
        })
    }
    
    func plaidIsConnected(){
        self.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: false)
        self.navigationController.popViewController(animated: true)
    }
    
    func onboardingComplete(){
        
        print("onboarding finished")
        
        self.parent?.currentBudget = self.budget
        self.parent?.onboardingComplete(self)
        

        
        self.navigationController.dismiss(animated: true)
        

    }
    
    func dismissPlaidLink(sender: PlaidLinkViewPresentor) {
        
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
        })

    }

    
    
}


