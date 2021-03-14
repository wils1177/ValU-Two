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

    var budget : Budget?
    
    func start() {
        
        self.budget = try? DataManager().getBudget()
        let viewModel = HistoryViewModel(budget: self.budget)
        viewModel.coordinator = self
        let vc = UIHostingController(rootView: HistoryTabView(viewModel: viewModel))

        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "book.closed"), selectedImage: UIImage(named: "tab_icon_seelcted"))
        self.navigationController.pushViewController(vc, animated: false)
        
        
        
    }
    
    func showBudgetDetail(budget: Budget, service: BudgetStatsService, title: String) {
        
        let view = HistoricalBudgetDetailView(budget: budget, service: service, title: title)
        let vc = UIHostingController(rootView: view)
        vc.title = title
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    

    

    func stop(){
        childCoordinators = [Coordinator]()
        self.navigationController = UINavigationController()
        self.presentorStack = [Presentor]()
    }


    

    
    
}
