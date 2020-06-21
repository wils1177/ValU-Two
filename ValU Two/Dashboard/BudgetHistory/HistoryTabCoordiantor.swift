//
//  HistoryTabCoordiantor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class HistoryTabCoordiantor : Coordinator{
    
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presentorStack = [Presentor]()
    var budget : Budget
    
    init(budget: Budget){
        
        self.budget = budget
        
    }
    
    
    func start() {
        
        let viewModel = HistoryViewModel(budget: self.budget)
        let vc = UIHostingController(rootView: HistoryTabView(viewModel: viewModel))

        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock"), selectedImage: UIImage(named: "tab_icon_seelcted"))
        self.navigationController.pushViewController(vc, animated: false)
        
        
        
    }
    

    

    


    

    
    
}
