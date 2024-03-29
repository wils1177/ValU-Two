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
    var presentorStack = [Presentor]()

    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var budget : Budget?
    var parent : BudgetsTabCoordinator?
    
    init(budget : Budget){
        self.budget = budget
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let presentor = EditBudgetViewModel(budget: self.budget!)
        presentor.coordinator = self
        let vc = presentor.configure()
        vc.title = "Edit Budgets"
        
        self.navigationController.pushViewController(vc, animated: true)
        self.navigationController.modalPresentationStyle = .overFullScreen
    }
    
    
    func dimiss(){
        self.presentorStack.removeAll()
        //self.navigationController.dismiss(animated: true)
        //self.navigationController = UINavigationController()
        self.parent!.dismissEdit()
    }
    
    func continueToPlaid() {
        
    }
    
    func timeFrameSubmitted() {
        
        self.navigationController.popViewController(animated: true)
    
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
        //vc.title = "Time Frame"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func incomeSubmitted(budget: Budget) {
        
        self.budget = budget
        //self.navigationController.popViewController(animated: false)
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    
    }
    
    func showIncomeTransactions(service: BudgetIncomeService){
        var view = IncomeTransactionsView(service: service)
        view.coordinator = self
        let vc = UIHostingController(rootView: view)
        self.navigationController.present(vc, animated: true)
    }
    
    func continueToSetSavings(){
        print("Contine to Set Savings Screen")
        let presentor = SetSavingsPresentor(budget: self.budget!)
        presentor.coordinator = self
        
        let view = SavingsSelectionView(viewModel: presentor)
        let vc = UIHostingController(rootView: view)
        vc.title = ""
        self.navigationController.pushViewController(vc, animated: true)
        
        
        //let setSavingsVC = presentor.configure()
        //self.navigationController.isNavigationBarHidden = true
        //self.navigationController.pushViewController(setSavingsVC, animated: true)
        //setSavingsVC.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func userTappedCustomSavings(presentor : SetSavingsPresentor){
        let setSavingsVC = presentor.configure()
        setSavingsVC.title = "Custom Goal"
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(setSavingsVC, animated: true)
        setSavingsVC.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func savingsSubmitted(budget: Budget, sender: SetSavingsPresentor) {
        self.budget = budget
        sender.objectWillChange.send()
        self.navigationController.popViewController(animated: true)
        DataManager().saveDatabase()
    }
    
    func continueToBudgetCategories(){

        let view = BalancerView(budget: self.budget!, coordinator: self)
        let vc = UIHostingController(rootView: view)
        vc.title = "Set Budgets"
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
    
    func showNewSectionView() {
        var view  = NewBudgetSectionView(budget: self.budget!)
        view.coordinator = self
        let vc = UIHostingController(rootView: view)
        
        self.navigationController.present(vc, animated: true)
    }
    
    func editBudgetSection(section: BudgetSection){
        var view  = NewBudgetSectionView(budget: self.budget!, editMode: true, existingSection: section)
        
        view.coordinator = self
        let vc = UIHostingController(rootView: view)
        
        self.navigationController.present(vc, animated: true)
    }
    
    func showNewCategoryView(budgetSection: BudgetSection){
        let vm = AddCategoriesViewModel(budgetSection: budgetSection)
        vm.coordinator = self
        var view  = EditBudgetCategoriesView(budgetSection: budgetSection, viewModel: vm)
        view.coordinator = self
        let vc = UIHostingController(rootView: view)
        
        self.navigationController.present(vc, animated: true)
    }
    
    func dismissPresented(){
        self.navigationController.dismiss(animated: true)
    }
    
    func showHistoricalTransactions(budgetCategory: BudgetCategory, model: HistoricalTransactionsViewModel){
        var view = HistoricalTransactionsView(viewModel: model, budgetCategory: budgetCategory)
        view.coordinator = self
        let vc = UIHostingController(rootView: view)
        vc.title = budgetCategory.spendingCategory!.name!
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showFullTransactionsList(){
        let tabModel = TransactionsTabViewModel()
        tabModel.coordinator = self
        let filterModel = TransactionFilterModel()
        let view = TransactionsTabView(viewModel: tabModel, filterModel: filterModel)
        let vc = UIHostingController(rootView: view)
        vc.title = "Transactions"
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    
    func showCategoryDetail(budgetSection: BudgetSection, viewModel: BudgetBalancerPresentor) {
        let view = BalanceDetailView(budgetSection: budgetSection, coordinator: self, viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        vc.title = budgetSection.name!
        
        
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showListOfTransactions(title: String, list: [Transaction]){
        let model = TransactionsListViewModel(transactions: list.sorted(by: { $0.date! > $1.date! }), title: title)
        let view = TransactionList(viewModel: model)
        model.coordinator = self
        let vc = UIHostingController(rootView: view)
        vc.title = title
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func goBack(){
        self.navigationController.popViewController(animated: true)
    }
    
    func categoryDetailDone(){
        goBack()
    }
    
    func finishSettingUpBudget(){
        
    }
    
    
    func continueToPlaid() {
        
    }
    
    

    
}

extension SetSpendingLimitDelegate{
    
}
