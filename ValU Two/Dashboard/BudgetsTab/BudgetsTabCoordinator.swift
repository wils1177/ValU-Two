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
    var newBudgetCoorinator : NewBudgetCoordinator?
    var plaidUpdateCoordiantor : PlaidUpdateFlowCoordinator?
    
    //Dependencids
    var budget : Budget?
    var budgetTransactionsService : BudgetTransactionsService?
    
    
    
    init(budget: Budget?){
        self.budget = budget
        
        if budget != nil{
            self.budgetTransactionsService = BudgetTransactionsService(budget: budget!)
        }
        
    }
    
    
    func start() {
        
        if self.budget != nil && budget!.active{
            let homePresentor = BudgetsViewModel(budget: self.budget!, budgetService: self.budgetTransactionsService!, coordinator: self)
            homePresentor.coordinator = self
            self.presentorStack.append(homePresentor)
            
            let homeView = homePresentor.configure()
            self.navigationController.pushViewController(homeView, animated: false)
        }
        else{
            let vc = UIHostingController(rootView: BudgetZeroState(coordinator: self))
            self.navigationController.pushViewController(vc, animated: false)
        }
        
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.tabBarItem = UITabBarItem(title: "Summary", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(named: "tab_icon_seelcted"))
        
        
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
    
    func editBudgets(budget : Budget){
        
    }
    
    func settingsClicked(){
        showSettings()
    }
    
    func showSettings(){
        
        self.settingsCoordinator = SettingsFlowCoordinator()
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
    
    func showCategory(category: SpendingCategory){
        
        let transactions = TransactionsCategoryFetcher.fetchTransactionsForCategoryAndDateRange(spendingCategory: category, startDate: self.budget!.startDate!, endDate: self.budget!.endDate!)
        let presentor = TransactionsListViewModel(transactions: transactions, title: category.name!)
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showOtherTransactions(){
        let transactions = self.budgetTransactionsService!.getOtherTransactionsInBudget()
        let presentor = TransactionsListViewModel(transactions: transactions, title: "Everything Else")
        presentor.coordinator = self
        let vc = presentor.configure()
        vc.title = "Everything Else"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showIncome(transactions: [Transaction]){

        let presentor = TransactionsListViewModel(transactions: transactions, title: "Earnings")
        presentor.coordinator = self
        let vc = presentor.configure()
        vc.title = "Earnings"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showExpenses(transactions: [Transaction]){
        let presentor = TransactionsListViewModel(transactions: transactions, title: "Spent")
        presentor.coordinator = self
        let vc = presentor.configure()
        vc.title = "Spent"
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    func showCashFlow(viewModel: CashFlowViewModel){
        let view = CashFlowFullScreenView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        vc.title = "Cash Flow"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func showIndvidualBudget(budgetSection: BudgetSection){
        let viewModel = BudgetDetailViewModel(budgetSection: budgetSection)
        let view = CategoryDetailView(sectionModel: viewModel, coordinator: self)
        let vc = UIHostingController(rootView: view)
        vc.title = budgetSection.name!
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func continueToBudgetCategories(){

        let view = BalancerView(budget: self.budget!, coordinator: self)
        let vc = UIHostingController(rootView: view)
        vc.title = "Set Budget"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showCategoryDetail(budgetSection: BudgetSection, service: BalanceParentService) {
        //let view = BalanceDetailView(budgetSection: budgetSection, service: service, coordinator: self)
        //let vc = UIHostingController(rootView: view)
        //vc.title = budgetSection.name!
        

        
        //self.navigationController.pushViewController(vc, animated: true)
    }
    

    
    func finishedSettingLimits() {
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    }
    
    func showPlaidUpdate(publicToken: String, itemId: String, sender: FixNowService){
        self.plaidUpdateCoordiantor = PlaidUpdateFlowCoordinator(navigationController: self.navigationController, itemId: itemId, publicToken: publicToken, fixNowService : sender)
        plaidUpdateCoordiantor?.start()
        
    }
    
    
    func createNewBudget(){
        
        self.newBudgetCoorinator = NewBudgetCoordinator()
        self.newBudgetCoorinator?.parent = self
        self.newBudgetCoorinator?.start()
        self.navigationController.present(self.newBudgetCoorinator!.navigationController, animated: true)
        
    }
    
    func dismissNewBudgetCoordinator(){
        self.newBudgetCoorinator = nil
    }
    
    func showNewSectionView() {
        
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




