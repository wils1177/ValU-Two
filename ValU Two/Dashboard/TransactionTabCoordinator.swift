//
//  TransactionTabCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class TransactionsTabCoordinator : Coordinator{
    
    var childCoordinators = [Coordinator]()
    var view : UIViewController?
    
    init(){
        
    }
    
    
    func start() {
        
        let viewModel = TransactionsTabViewModel()
        let vc = viewModel.configure()
        self.view = vc
        
        self.view?.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
    }
    
    
}
