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
    
    var budgetTransactionsService : BudgetTransactionsService?
    
    var parent: MainTabBarController?
    
    //Dependencids
    var budget : Budget?
    
    
    
  
    
    func start() {
        self.budget = try? DataManager().getBudget()
        self.presentorStack.removeAll()
        self.navigationController = UINavigationController()
        
        //navigationController.navigationBar.barTintColor = UIColor(Color(hex:"FFF0E6"))
        
        
        
        if self.budget != nil && budget!.active{
            self.budgetTransactionsService = BudgetTransactionsService(budget: self.budget!)
            let homePresentor = BudgetsViewModel(budget: self.budget!, coordinator: self, service: self.budgetTransactionsService!)
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
        self.navigationController.tabBarItem = UITabBarItem(title: "Budget", image: UIImage(systemName: "mail.stack", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), selectedImage: UIImage(named: "tab_icon_seelcted"))
        
        
    }
    
    func editClicked(budgetToEdit: Budget){
        print("edit clicked!!")
        showEdit(budgetToEdit: budgetToEdit)
    }
    
    func showEdit(budgetToEdit: Budget){
        let editCoordinator = EditCoordiantor(budget: budgetToEdit)
        self.childCoordinators.append(editCoordinator)
        editCoordinator.parent = self
        editCoordinator.start()
        //self.navigationController.present(editCoordinator.navigationController, animated: true)
        self.parent?.present(editCoordinator.navigationController, animated: true)
    }
    
    func dismissEdit(){
        print("Dismissing Edit Coordinator")
        let coord = self.childCoordinators.popLast() as! EditCoordiantor
        //coord.navigationController.dismiss(animated: true)
        self.parent?.dismiss(animated: true)
        
        //let owner = parent!
        //owner.onboardingCanLaod = true
        //owner.setupViews()
        
    }
    
    func editBudgets(budget : Budget){
        
    }
    
    func settingsClicked(){
        showSettings()
    }
    
    func showCategoryDetail(budgetSection: BudgetSection, viewModel: BudgetBalancerPresentor) {
        
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
    
    
    func showCalendar(){
        let view = CalendarView(budget: self.budget!, service: self.budgetTransactionsService!, coordinator: self)
        let vc = UIHostingController(rootView: view)
        vc.title = "Calendar"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func showCategory(category: SpendingCategory){
        
        let transactions = TransactionsCategoryFetcher.fetchTransactionsForCategoryAndDateRange(spendingCategory: category, startDate: self.budget!.startDate!, endDate: self.budget!.endDate!)
        let presentor = TransactionsListViewModel(transactions: transactions, title: category.name!)
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showOtherTransactions(otherCardData: SpendingCategoryViewData){
        
        let viewModel = OtherBudgetViewModel(budgetTransactionsService: self.budgetTransactionsService!)
        let view = OtherDetailView(viewModel: viewModel, coordinator: self, otherCardData: otherCardData)
        let vc = UIHostingController(rootView: view)
        vc.title = "Other"
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showIncome(transactions: [Transaction]){

        let presentor = TransactionsListViewModel(transactions: transactions, title: "Earnings")
        presentor.coordinator = self
        let vc = presentor.configure()
        vc.title = "Earnings"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showTransactionsForDate(title: String, date: Date){
        let transactions = self.budgetTransactionsService!.getTransactionsForDate(date: date)
        let presentor = TransactionsListViewModel(transactions: transactions, title: title)
        presentor.coordinator = self
        let vc = presentor.configure()
        vc.title = title
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
        let view = CategoryDetailView(section: budgetSection, coordinator: self)
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
    
    func showCategoryDetail(category: BudgetCategory) {
        let view = BudgetCategoryDetailView(category: category, coordinator: self)
        let vc = UIHostingController(rootView: view)
        vc.title = category.spendingCategory!.name!
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    
    func finishedSettingLimits() {
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    }
    
    func showPlaidUpdate(itemId: String, sender: FixNowService){
        self.plaidUpdateCoordiantor = PlaidUpdateFlowCoordinator(navigationController: self.navigationController, itemId: itemId, fixNowService : sender)
        plaidUpdateCoordiantor?.start()
        
    }
    
    
    func createNewBudget(){
        
        self.newBudgetCoorinator = NewBudgetCoordinator()
        self.newBudgetCoorinator?.parent = self
        self.newBudgetCoorinator?.start()
        self.navigationController.present(self.newBudgetCoorinator!.navigationController, animated: true)
        
    }
    
    func completedNewBudget(){
        dismissNewBudgetCoordinator()
        let owner = parent!
        owner.onboardingCanLaod = true
        self.parent = nil
        self.budget = try? DataManager().getBudget()
        owner.setupViews()
        
    }
    
    func dismissNewBudgetCoordinator(){
        self.newBudgetCoorinator?.parent = nil
        self.newBudgetCoorinator = nil
    }
    
    func showNewSectionView() {
        
    }
    
    func editBudgetSection(section: BudgetSection){
        
    }
    
    func showEditBudgetSectionIndividually(section: BudgetSection){
        
        let coordinator = EditBudgetSectionCoordinator(budget: self.budget!, section: section)
        self.childCoordinators.append(coordinator)
        coordinator.parent = self
        coordinator.start()
        self.navigationController.present(coordinator.navigationController, animated: true)
        
    }
    
    func showListOfTransactions(title: String, list: [Transaction]){
        let model = TransactionsListViewModel(transactions: list.sorted(by: { $0.date! > $1.date! }), title: title)
        let view = TransactionList(viewModel: model)
        model.coordinator = self
        let vc = UIHostingController(rootView: view)
        vc.title = title
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    func stop(){
        childCoordinators = [Coordinator]()
        self.navigationController = UINavigationController()
        self.presentorStack = [Presentor]()
        self.budget = nil
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





