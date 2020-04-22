//
//  AccountVsiewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class AccountViewData : Hashable{
    static func == (lhs: AccountViewData, rhs: AccountViewData) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name:String
    var balance: String
    var mask : String
    
    init(name:String, balance:String, mask : String){
        self.name = name
        self.balance = balance
        self.mask = mask
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)

    }
    
}

class AccountsViewModel {
    
    var accounts = [AccountData]()
    let dataManager  = DataManager()
    var accountViewData = [AccountViewData]()
    
    init(){
        self.accounts = dataManager.getAccounts()
        generateViewData()
    }
    
    func generateViewData(){
        for account in accounts{
            self.accountViewData.append(AccountViewData(name: account.officialName ?? "Un-Named", balance: String(account.balances!.current), mask: account.mask ?? "XXXX" ))
        }
    }
    
}
