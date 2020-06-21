//
//  EditCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class EditCoordiantor : BudgetEditableCoordinator{
    
    

    var childCoordinators = [Coordinator]()
    var navigationController : UINavigationController
    var budget : Budget?
    var parent : BudgetsTabCoordinator?
    
    init(budget : Budget, navigationController: UINavigationController){
        self.budget = budget
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let presentor = EditBudgetViewModel(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        vc.title = "More"
        
        self.navigationController.pushViewController(vc, animated: true)
        self.navigationController.modalPresentationStyle = .fullScreen
    }
    
    
    func dimiss(){
        self.navigationController.dismiss(animated: true)
        self.navigationController = UINavigationController()
        self.parent?.dismissEdit()
    }
    
    func continueToPlaid() {
        
    }
    
    

    
    
}

extension BudgetEditableCoordinator{
    
    func loadIncomeScreen(){

        let presentor = EnterIncomePresentor(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
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
    
    func incomeSubmitted(budget: Budget) {
        
        self.budget = budget
        self.navigationController.popViewController(animated: false)
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    
    }
    
    func continueToSetSavings(){
        print("Contine to Set Savings Screen")
        let presentor = SetSavingsPresentor(budget: self.budget!)
        presentor.coordinator = self
        let setSavingsVC = presentor.configure()
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(setSavingsVC, animated: true)
        setSavingsVC.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func savingsSubmitted(budget: Budget, sender: SetSavingsPresentor) {
        self.budget = budget
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    }
    
    func continueToBudgetCategories(){

        let view = BalancerView(budget: self.budget!, coordinator: self)
        let vc = UIHostingController(rootView: view)
        vc.title = "Set Budget"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func finishedSettingLimits() {
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    }
    
    func continueToBudgetType(){
        let presentor = BudgetTypePresentor(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func confirmBudgetType() {
        
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
        
    }
    

    
    func showCategoryDetail(category: SpendingCategory, service: BalanceParentService) {
        let view = BalanceDetailView(category: category, service: service)
        let vc = UIHostingController(rootView: view)
        vc.title = category.name!
        

        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func continueToPlaid() {
        
    }
    
    func dimiss() {
        
    }

    
}

extension SetSpendingLimitDelegate{
    
}
