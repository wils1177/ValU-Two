//
//  HistoryTabCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class MoneyTabCoordinator : Coordinator, TransactionRowDelegate{
    
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presentorStack = [Presentor]()
    var budget : Budget? = nil

    
    
    func start() {
        self.navigationController = UINavigationController()
        let viewModel = MyMoneyViewModel(coordinator: self)
        let vc = viewModel.configure()

        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.tabBarItem = UITabBarItem(title: "Accounts", image: UIImage(systemName: "dollarsign.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), selectedImage: UIImage(named: "tab_icon_seelcted"))
        self.navigationController.pushViewController(vc, animated: false)
        
        
        
    }
    
    func showAccountDetail(account: AccountData){
        let view = AccountDetailView(coordinator: self, account: account)
        let vc = UIHostingController(rootView: view)
        vc.title = account.name!
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func stop(){
        childCoordinators = [Coordinator]()
        self.navigationController = UINavigationController()
        self.presentorStack = [Presentor]()
        self.budget = nil
    }
    

    


    

    
    
}
