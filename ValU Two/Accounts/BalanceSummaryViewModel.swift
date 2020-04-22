//
//  BalanceSummaryViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class BalanceSummaryViewModel {
    
    var accounts = [AccountData]()
    let dataManager  = DataManager()
    var totalAccountBalance = 0.0
    
    init(){
        self.accounts = dataManager.getAccounts()
        self.totalAccountBalance = getBalanceTotal()
    }
    
    func getBalanceTotal() -> Double{
        var total = 0.0
        for account in self.accounts{
            total = total + account.balances!.available
        }
        return total
    }
    

    
}
