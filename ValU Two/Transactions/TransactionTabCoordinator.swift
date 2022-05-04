//
//  TransactionTabCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class TransactionsTabCoordinator : Coordinator, TransactionRowDelegate{
    

    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presentorStack = [Presentor]()
    
    var budget: Budget?
    
    func start() {
        self.navigationController = UINavigationController()
        self.presentorStack = [Presentor]()
        self.budget = try? DataManager().getBudget()
        
        let viewModel = TransactionsTabViewModel()
        viewModel.coordinator = self
        let vc = viewModel.configure()
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(systemName: "arrow.up.arrow.down.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), selectedImage: UIImage(named: "tab_icon_seelcted"))
        self.navigationController.pushViewController(vc, animated: false)
        
    }
    
    
    func stop(){
        childCoordinators = [Coordinator]()
        self.navigationController = UINavigationController()
        self.presentorStack = [Presentor]()
        self.budget = nil
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
    
    func showFilterEditView(filterModel : TransactionFilterModel){
        
        var view = TransactionFilterEditView(filterModel: filterModel)
        view.coordinator = self as? TransactionsTabCoordinator
        let vc = UIHostingController(rootView: view)
        vc.title = "Edit Filters"
        self.navigationController.present(vc, animated: true)
        
    }
    
    func showTransactionDetail(transaction: Transaction){
        
        let presentor = TransactionDetailViewModel(transaction: transaction, service: TransactionService(), budget: self.budget)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        //self.navigationController.navigationBar.shadowImage = UIImage()
        //self.navigationController.navigationBar.isTranslucent = true
        //self.navigationController.view.backgroundColor = .systemGroupedBackground

        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func showSplitTransaction(transaction: Transaction){
        let presentor = SplitTransactionCategoryViewModel(transaction: transaction, budget: self.budget ?? nil)
        self.presentorStack.append(presentor)
        let view = SplitTransactionCategoriesView(viewModel: presentor)
        presentor.coordinator = self
        let vc = UIHostingController(rootView: view)
        
        self.navigationController.present(vc, animated: true)
    }
    
    
    func showShareTransaction(transaction: Transaction){
        let view = SplitTransactionView()
        let vc = UIHostingController(rootView: view)
        self.navigationController.present(vc, animated: true)
    }

    
    func dismissEditCategory() {
        self.presentorStack.popLast()
        self.navigationController.dismiss(animated: true)
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true)
    }
    
    
    
}
