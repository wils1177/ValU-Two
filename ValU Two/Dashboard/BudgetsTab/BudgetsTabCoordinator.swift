//
//  HomeTabCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class BudgetsTabCoordinator : Coordinator, TransactionRowDelegate, EditBudgetDelegate{
    

    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presentorStack = [Presentor]()
    var settingsCoordinator : SettingsFlowCoordinator?
    var budget: Budget
    
    
    init(budget: Budget){
        self.budget = budget
        
    }
    
    
    func start() {
        
        let homePresentor = BudgetsViewModel()
        homePresentor.coordinator = self
        self.presentorStack.append(homePresentor)
        
        let homeView = homePresentor.configure()
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        self.navigationController.tabBarItem = UITabBarItem(title: "Budgets", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(named: "tab_icon_seelcted"))
        self.navigationController.pushViewController(homeView, animated: false)
        
    }
    
    func editClicked(budgetToEdit: Budget){
        showEdit(budgetToEdit: budgetToEdit)
    }
    
    func showEdit(budgetToEdit: Budget){
        let editCoordinator = EditCoordiantor(budget: budgetToEdit)
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
        self.navigationController.interactivePopGestureRecognizer!.delegate = nil
        
        let presentor = TransactionsListViewModel(budget: self.budget, categoryName: categoryName)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showIncome(){
        let presentor = TransactionsListViewModel(budget: self.budget, predicate: PredicateBuilder().generateNegativeAmountPredicate(startDate: self.budget.startDate!, endDate: self.budget.endDate!) , title: "Income")
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func makeNewBudget(budget: Budget){
        
        
        let newBudgetCoordinator = NewBudgetCoordinator(budget: budget)
        newBudgetCoordinator.parent = self
        newBudgetCoordinator.start()
        self.childCoordinators.append(newBudgetCoordinator)
        
        self.navigationController.present(newBudgetCoordinator.navigationController, animated: true)
        
    }
    
    func dismissNewBudgetCoordinator(){
        self.childCoordinators.popLast()
    }
    
    func showFutureBudgets(futureTimeFrames: [BudgetTimeFrame], viewModel: BudgetsViewModel){
        
        let vc = UIHostingController(rootView: FutureBudgetsView(timeFrames: futureTimeFrames, viewModel: viewModel))
        vc.title = "Upcomming"
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showPastBudgets(pastTimeFrames: [Budget], viewModel: BudgetsViewModel){
        
        let vc = UIHostingController(rootView: PastBudgetsView(budgets: pastTimeFrames, viewModel: viewModel))
        vc.title = "History"
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
    
    func showTransactionDetail(transaction: Transaction){
        
        let presentor = TransactionDetailViewModel(transaction: transaction)
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    
    func dismissEditCategory() {
        self.presentorStack.popLast()
        self.navigationController.dismiss(animated: true)
    }
    
}




