//
//  HomeTabCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class BudgetsTabCoordinator : Coordinator, TransactionRowDelegate, EditBudgetDelegate, SetSpendingLimitDelegate{
    
    
     

    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presentorStack = [Presentor]()
    var settingsCoordinator : SettingsFlowCoordinator?
    var plaidUpdateCoordiantor : PlaidUpdateFlowCoordinator?
    var budget : Budget
    
    init(budget: Budget){
        self.budget = budget
        
    }
    
    
    func start() {
        
        let homePresentor = BudgetsViewModel(budget: self.budget, coordinator: self)
        homePresentor.coordinator = self
        self.presentorStack.append(homePresentor)
        
        let homeView = homePresentor.configure()
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        self.navigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(named: "tab_icon_seelcted"))
        self.navigationController.pushViewController(homeView, animated: false)
        
    }
    
    func editClicked(budgetToEdit: Budget){
        showEdit(budgetToEdit: budgetToEdit)
    }
    
    func showEdit(budgetToEdit: Budget){
        let editCoordinator = EditCoordiantor(budget: budgetToEdit, navigationController: self.navigationController)
        //self.childCoordinators.append(editCoordinator)
        //editCoordinator.parent = self
        editCoordinator.start()
        
    }
    
    func editBudgets(budget : Budget){
        
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
    
    func showIncome(transactions: [Transaction]){
        let presentor = TransactionsListViewModel(budget: self.budget, transactions: transactions , title: "Earned")
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showExpenses(transactions: [Transaction]){
        let presentor = TransactionsListViewModel(budget: self.budget, transactions: transactions , title: "Spent")
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    
    func dismissNewBudgetCoordinator(){
        self.childCoordinators.popLast()
    }
    
 
    
    func showCashFlow(viewModel: CashFlowViewModel){
        let view = CashFlowFullScreenView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        vc.title = "Cash Flow"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func showIndvidualBudget(spendingCategory: SpendingCategory){
        let view = CategoryDetailView(spendingCategory: spendingCategory, coordinator: self)
        let vc = UIHostingController(rootView: view)
        vc.title = spendingCategory.name! + " Budget"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func continueToBudgetCategories(){

        let view = BalancerView(budget: self.budget, coordinator: self)
        let vc = UIHostingController(rootView: view)
        vc.title = "Set Budget"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showCategoryDetail(category: SpendingCategory, service: BalanceParentService) {
        let view = BalanceDetailView(category: category, service: service)
        let vc = UIHostingController(rootView: view)
        vc.title = category.name!
        

        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func finishedSettingLimits() {
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    }
    
    func showPlaidUpdate(publicToken: String, itemId: String, sender: FixNowService){
        self.plaidUpdateCoordiantor = PlaidUpdateFlowCoordinator(navigationController: self.navigationController, itemId: itemId, publicToken: publicToken, fixNowService : sender)
        plaidUpdateCoordiantor?.start()
        
    }
    


    
}



public extension UIImage {
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
}




