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
        self.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        self.navigationController.pushViewController(vc, animated: false)
        
    }
    

    

    
    
}