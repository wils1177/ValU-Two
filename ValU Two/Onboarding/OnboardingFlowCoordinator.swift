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


struct OnboardingDependencies {
    var itemManager = ItemManagerService()
    var onboardingSummaryPresentor : OnboardingSummaryPresentor?
}


class OnboardingFlowCoordinator : Coordinator, StartPageViewDelegate, SetSavingsViewDelegate, PlaidLinkDelegate, BudgetCategoriesDelegate, SetSpendingLimitDelegate, IncomeCoordinator, BudgetTypeDelegate, BudgetEditableCoordinator{
    

    // Dependencies
    var budget : Budget?
    var onboardingDependencies = OnboardingDependencies()
    
    var childCoordinators = [Coordinator]()
    weak var parent: AppCoordinator?
    var navigationController : UINavigationController
    
    var presentorStack = [Presentor]()
    
    
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
            
        }
        else{
            self.budget = existingBudget

        }
        
        var view = WelcomeView()
        view.coordinator = self
        let vc = UIHostingController(rootView: view)
        vc.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: false)
        
        
    }
    
    func continueToOnboarding() {
        print("Contionue to onboarding")
        
        
        showSummary()

    }
    
    func showSummary(){
        self.onboardingDependencies.onboardingSummaryPresentor = OnboardingSummaryPresentor(budget: self.budget!, itemManagerService: self.onboardingDependencies.itemManager)
        self.onboardingDependencies.onboardingSummaryPresentor!.coordinator = self
        let vc = self.onboardingDependencies.onboardingSummaryPresentor!.configure()
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func continueToBudgetType(){
        let presentor = BudgetTypePresentor(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func confirmBudgetType() {
        
        self.navigationController.popViewController(animated: true)
        self.onboardingDependencies.onboardingSummaryPresentor?.generateViewData()
        DataManager().saveDatabase()
        
    }
    

    
    func continueToSetSavings(){
        print("Contine to Set Savings Screen")
        let presentor = SetSavingsPresentor(budget: self.budget!)
        presentor.coordinator = self
        self.presentorStack.append(presentor)
        let setSavingsVC = presentor.configure()
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(setSavingsVC, animated: true)
        setSavingsVC.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func savingsSubmitted(budget: Budget, sender: SetSavingsPresentor){
        self.budget = budget
        self.onboardingDependencies.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
        presentorStack.popLast()
        
    }
    
    func continueToBudgetCategories(){
        print("Contine to Budget Categories")
        let view = BalancerView(budget: self.budget!, coordinator: self)
        
        let vc = UIHostingController(rootView: view)
        vc.title = "Set Budget"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func continueToTimeFrame(){
        let model = TimeFrameViewModel(budget: self.budget!)
        model.coordinator = self
        let view = TimeFrameView(viewModel: model)
        let vc = UIHostingController(rootView: view)
        vc.title = "Frequency"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func loadIncomeScreen(){

        let presentor = EnterIncomePresentor(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    func incomeSubmitted(budget: Budget) {
        
        self.budget = budget
        self.onboardingDependencies.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: false)
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    
    }
    
    func showCategoryDetail() {
        
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
        
        self.presentorStack = [Presentor]()
        let presentor = LoadingAccountsPresentor(budget : self.budget!, itemManager: self.onboardingDependencies.itemManager)
        presentor.coordinator = self
        presentor.viewData.viewState = LoadingAccountsViewState.Initial
        self.presentorStack.append(presentor)
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    func launchPlaidLink(){
        let presentor = PlaidLinkViewPresentor()
        presentor.coordinator = self
        self.presentorStack.append(presentor)
        let linkVC = presentor.configure()
        linkVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(linkVC, animated: true)
        
    }
    
    func plaidLinkSuccess(sender: PlaidLinkViewPresentor){
        
        print("Plaid LInk SUccess Triggered in Coordiantor")
        self.presentorStack.popLast()
        let loadingAccountsPresentor = self.presentorStack.first! as! LoadingAccountsPresentor
        loadingAccountsPresentor.startLoadingAccounts()
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
            
        })
    }
    
    func plaidIsConnected(){
        self.onboardingDependencies.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: true)
        self.presentorStack.popLast()
    }
    
    func connectMoreAccounts(){
        self.onboardingDependencies.onboardingSummaryPresentor?.generateViewData()
        launchPlaidLink()
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


