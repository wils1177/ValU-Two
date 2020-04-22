//
//  HistoryTabCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class MoneyTabCoordinator : Coordinator{
    
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presentorStack = [Presentor]()
    var budget : Budget
    
    init(budget: Budget){
        
        self.budget = budget
        
    }
    
    
    func start() {
        
        let viewModel = MyMoneyViewModel()
        let vc = viewModel.configure()

        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.tabBarItem = UITabBarItem(title: "My Money", image: UIImage(systemName: "dollarsign.circle"), selectedImage: UIImage(named: "tab_icon_seelcted"))
        self.navigationController.pushViewController(vc, animated: false)
        
        
        
    }
    
    

    


    

    
    
}
