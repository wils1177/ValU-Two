//
//  EditBudgetSectionCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/13/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import SwiftUI

class EditBudgetSectionCoordinator : BudgetEditableCoordinator{
    
    var presentorStack = [Presentor]()
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var budget : Budget?
    var parent : BudgetsTabCoordinator?
    
    var section : BudgetSection
    
    init(budget : Budget, section: BudgetSection){
        self.section = section
        self.budget = budget
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        self.navigationController.isModalInPresentation = true
        
        let parentView = BalancerView(budget: self.budget!, coordinator: self)
        let parentVC = UIHostingController(rootView: parentView)
        parentVC.title = "Set Budgets"
        
        let childView = BalanceDetailView(budgetSection: self.section, coordinator: self, viewModel: parentView.viewModel)
        let childVC = UIHostingController(rootView: childView)
        childVC.title = self.section.name!
        
        self.navigationController.pushViewController(parentVC, animated: false)
        self.navigationController.pushViewController(childVC, animated: false)
        self.navigationController.modalPresentationStyle = .pageSheet
        
        
    }
    
    func dimiss() {
        self.presentorStack.removeAll()
        self.navigationController.dismiss(animated: true)
        self.navigationController = UINavigationController()
        self.parent!.dismissEdit()
    }
    
    func finishedSettingLimits() {
        dismiss()
    }
    
    func categoryDetailDone(){
        dismiss()
    }
    
    
    func timeFrameSubmitted() {
        
    }
    
    
    
    
    
    
    
    
    
    

    

}
