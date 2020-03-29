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
    var navigationController = UINavigationController()
    var budget : Budget?
    var parent : HomeTabCoordinator?
    
    init(budget : Budget){
        self.budget = budget
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let presentor = EditBudgetViewModel(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: false)
        self.navigationController.modalPresentationStyle = .fullScreen
    }
    
    
    func dimiss(){
        self.navigationController.dismiss(animated: true)
        self.navigationController = UINavigationController()
        self.parent?.dismissEdit()
    }

    
    
}

extension BudgetEditableCoordinator{
    
    func loadIncomeScreen(){

        let presentor = EnterIncomePresentor(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func incomeSubmitted(budget: Budget, sender: EnterIncomePresentor) {
        
        self.budget = budget
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    
    }
    
    func continueToSetSavings(){
        print("Contine to Set Savings Screen")
        let presentor = SetSavingsPresentor(budget: self.budget!)
        presentor.coordinator = self
        let setSavingsVC = presentor.configure()
        //self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(setSavingsVC, animated: true)
        //setSavingsVC.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func savingsSubmitted(budget: Budget, sender: SetSavingsPresentor) {
        self.budget = budget
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    }
    
    func editBudgetCategories(){
        let presentor = BudgetBalancerPresentor(budget: self.budget!)
        let vc = presentor.configure()
        presentor.coordinator = self
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func finishedSettingLimits() {
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    }
    
    func setMonth(){
        
    }

    
}
