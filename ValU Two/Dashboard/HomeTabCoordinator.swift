//
//  HomeTabCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class HomeTabCoordinator : Coordinator, TransactionRowDelegate{
    

    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presentorStack = [Presentor]()
    var settingsCoordinator : SettingsFlowCoordinator?
    var budget: Budget
    
    
    init(budget: Budget){
        self.budget = budget
        
    }
    
    
    func start() {
        
        let homePresentor = HomeViewModel(budget: budget)
        homePresentor.coordinator = self
        self.presentorStack.append(homePresentor)
        
        let homeView = homePresentor.configure()
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        self.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        self.navigationController.pushViewController(homeView, animated: false)
        
    }
    
    func editClicked(){
        showEdit()
    }
    
    func showEdit(){
        let editCoordinator = EditCoordiantor(budget: self.budget)
        self.childCoordinators.append(editCoordinator)
        editCoordinator.parent = self
        editCoordinator.start()
        self.navigationController.present(editCoordinator.navigationController, animated: true)
        
    }
    
    func settingsClicked(){
        showSettings()
    }
    
    func showSettings(){
        
        self.settingsCoordinator = SettingsFlowCoordinator(budget: self.budget)
        self.settingsCoordinator?.parent = self
        self.settingsCoordinator?.start()
        self.navigationController.present(self.settingsCoordinator!.navigationController, animated: true)
        

        
    }
    
    func dismissSettings(){
        
        self.settingsCoordinator = nil
        
    }
    
    func dismissEdit(){
        
        self.childCoordinators.popLast()
        
    }
    
    func showCategory(categoryName: String){
        
        let presentor = TransactionsListViewModel(budget: self.budget, categoryName: categoryName)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}

extension TransactionRowDelegate{
    
    func showEditCategory(transaction: Transaction) {
        
        let presentor = EditCategoryViewModel(transaction: transaction, budget: self.budget)
        self.presentorStack.append(presentor)
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.present(vc, animated: true)
        
    }
    

    
    func dismissEditCategory() {
        self.presentorStack.popLast()
        self.navigationController.dismiss(animated: true)
    }
    
}


