//
//  NewBudgetCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct NewBudgetDependencies {
    var itemManager = ItemManagerService()
    var onboardingSummaryPresentor : OnboardingSummaryPresentor?
}

class NewBudgetCoordinator : Coordinator, BudgetEditableCoordinator {
    
    var budget : Budget?
    var newBudgetDependencies = NewBudgetDependencies()
    
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    
    var presentorStack = [Presentor]()
    var parent : BudgetsTabCoordinator?


    
    func start(){

        print("new budget flow started")
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        self.budget = DataManager().createNewBudget()
        
        self.navigationController.modalPresentationStyle = .fullScreen
        self.newBudgetDependencies.onboardingSummaryPresentor = OnboardingSummaryPresentor(budget: self.budget!, itemManagerService: self.newBudgetDependencies.itemManager)
        self.newBudgetDependencies.onboardingSummaryPresentor!.coordinator = self
        let vc = self.newBudgetDependencies.onboardingSummaryPresentor!.configure()
        self.navigationController.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    func continueToTimeFrame(){
        let model = TimeFrameViewModel(budget: self.budget!)
        model.coordinator = self
        let view = TimeFrameView(viewModel: model)
        let vc = UIHostingController(rootView: view)
        vc.title = "Time Frame"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func timeFrameSubmitted(){
        self.newBudgetDependencies.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: true)
    }
    
    func loadIncomeScreen(){

        let presentor = EnterIncomePresentor(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    func incomeSubmitted(budget: Budget) {
        
        self.budget = budget
        self.newBudgetDependencies.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    
    }
    
    func continueToSetSavings(){
        print("Contine to Set Savings Screen")
        let presentor = SetSavingsPresentor(budget: self.budget!)
        presentor.coordinator = self
        self.presentorStack.append(presentor)
        let setSavingsVC = presentor.configure()
        setSavingsVC.title = "Savings Goal"
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(setSavingsVC, animated: true)
        setSavingsVC.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func savingsSubmitted(budget: Budget, sender: SetSavingsPresentor){
        self.budget = budget
        self.newBudgetDependencies.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
        presentorStack.popLast()
        
    }
    
    func dimiss(){
        self.navigationController.dismiss(animated: true)
        
        let id = self.budget!.id!
        let predicate = PredicateBuilder().generateByIdPredicate(id: id)
        try! DataManager().deleteEntity(predicate: predicate, entityName: "Budget")
        
        
        self.parent?.dismissNewBudgetCoordinator()
        
        
    }
    
    func finishedSettingLimits() {
        
        self.newBudgetDependencies.onboardingSummaryPresentor?.generateViewData()
        self.navigationController.popViewController(animated: true)
        
    }
    
    
    func finishSettingUpBudget(){
        self.budget!.active = true
        self.navigationController.dismiss(animated: true)
        DataManager().saveDatabase()
        self.parent?.dismissNewBudgetCoordinator()
    }

    
    
    

}

extension BudgetEditableCoordinator{
    
    func dismiss(){
        self.navigationController.dismiss(animated: true)
    }
}
