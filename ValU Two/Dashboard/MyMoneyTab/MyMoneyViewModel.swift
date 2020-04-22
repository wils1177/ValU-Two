//
//  MyMoneyViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class MyMoneyViewModel: Presentor{
    
    var cashFlowViewModel = CashFlowViewModel()
    var accountsModel = AccountsViewModel()
    
    func configure() -> UIViewController {
        return UIHostingController(rootView: MyMoneyTabView(viewModel: self))
    }
    
}
