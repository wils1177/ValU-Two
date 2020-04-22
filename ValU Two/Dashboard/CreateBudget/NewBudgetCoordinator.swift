//
//  NewBudgetCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class NewBudgetCoordinator : BudgetEditableCoordinator{
    
    
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var budget : Budget?
    var parent : BudgetsTabCoordinator?
    
    var presentor : CreateBudgetViewModel?
    
    init(budget : Budget){
        self.budget = budget
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        
        let viewModel = CreateBudgetViewModel(budget: self.budget!)
        self.presentor = viewModel
        viewModel.coordinator = self
        let vc = viewModel.configure()
        
        self.navigationController.pushViewController(vc, animated: false)
        self.navigationController.modalPresentationStyle = .fullScreen

    }
    
    func incomeSubmitted(budget: Budget) {
        
        self.budget = budget
        self.presentor!.generateViewData()
        self.navigationController.popViewController(animated: true)
        
        DataManager().saveDatabase()
    
    }
    
    func savingsSubmitted(budget: Budget, sender: SetSavingsPresentor) {
        self.budget = budget
        self.presentor?.generateViewData()
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    }
    
    func finishedSettingLimits() {
        self.dimiss()
    }

    
    func dimiss(){
        self.navigationController.dismiss(animated: true)
        self.navigationController = UINavigationController()
        self.parent?.dismissNewBudgetCoordinator()
    }
    
    func cancel(){
        self.navigationController.dismiss(animated: true)
        try! DataManager().deleteEntity(predicate: PredicateBuilder().generateByIdPredicate(id: self.budget!.id!), entityName: "Budget")
        self.navigationController = UINavigationController()
        self.parent?.dismissNewBudgetCoordinator()
    }
    
    func setMonth(){
    
        
    }
    
    func setType() {
        
    }
    
    func confirmBudgetType() {
        
    }
    
    

    
    
}
