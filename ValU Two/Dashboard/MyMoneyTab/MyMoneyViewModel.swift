//
//  MyMoneyViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class MyMoneyViewModel: Presentor, ObservableObject{
    
    var cashFlowViewModel = CashFlowViewModel()
    var accountsModel = AccountsViewModel()
    var coordinator : MoneyTabCoordinator?
    
    init(coordinator :MoneyTabCoordinator){
        self.coordinator = coordinator
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    @objc func update(_ notification:Notification){
        print("Update to Accounts Tab Triggered")
        
        self.objectWillChange.send()
        
        
        
    }
    
    func configure() -> UIViewController {
        return UIHostingController(rootView: MyMoneyTabView(viewModel: self, coordinator: self.coordinator))
    }
    
}
