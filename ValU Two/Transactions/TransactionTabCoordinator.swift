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
    var view : UIViewController?
    var navigationController = UINavigationController()
    var presentorStack = [Presentor]()


    func start() {
        
        let viewModel = TransactionsTabViewModel()
        viewModel.coordinator = self
        let vc = viewModel.configure()
        self.view = vc
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(systemName: "arrow.up.arrow.down"), selectedImage: UIImage(named: "tab_icon_seelcted"))
        self.navigationController.pushViewController(vc, animated: false)
        
    }
    

    

    
    
}

extension TransactionRowDelegate{
    
    func showEditCategory(transaction: Transaction) {
        
        let presentor = EditCategoryViewModel(transaction: transaction)
        self.presentorStack.append(presentor)
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.present(vc, animated: true)
        
    }
    
    func showTransactionDetail(transaction: Transaction){
        
        let presentor = TransactionDetailViewModel(transaction: transaction)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.navigationBar.shadowImage = UIImage()
        self.navigationController.navigationBar.isTranslucent = true
        self.navigationController.view.backgroundColor = .systemGroupedBackground

        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func showSplitTransaction(transaction: Transaction){
        let view = SplitTransactionView()
        let vc = UIHostingController(rootView: view)
        self.navigationController.present(vc, animated: true)
    }
    

    
    func dismissEditCategory() {
        self.presentorStack.popLast()
        self.navigationController.dismiss(animated: true)
    }
    
    
    
}
