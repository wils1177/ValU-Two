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
    
    init(budget : Budget){
        self.budget = budget
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        
        let viewModel = CreateBudgetViewModel(budget: self.budget!)
        viewModel.coordinator = self
        let vc = viewModel.configure()
        
        self.navigationController.pushViewController(vc, animated: false)
        self.navigationController.modalPresentationStyle = .fullScreen

    }
    

    
    func dimiss(){
        self.navigationController.dismiss(animated: true)
        self.navigationController = UINavigationController()
        self.parent?.dismissNewBudgetCoordinator()
    }
    
    func setMonth(){
        
        let presentor = SetMonthViewModel(budget: self.budget!)
        let vc = presentor.configure()
        presentor.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func monthSet(){
        self.navigationController.popViewController(animated: true)
    }

    
    
}
