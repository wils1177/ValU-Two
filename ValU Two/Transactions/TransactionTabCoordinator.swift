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
    var budget : Budget
    
    init(budget: Budget){
        
        self.budget = budget
        
    }
    
    
    func start() {
        
        let viewModel = TransactionsTabViewModel(budget: self.budget)
        viewModel.coordinator = self
        let vc = viewModel.configure()
        self.view = vc
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left"), selectedImage: UIImage(named: "tab_icon_seelcted"))
        self.navigationController.pushViewController(vc, animated: false)
        
    }
    

    

    
    
}
