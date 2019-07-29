//
//  Account.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/13/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

class Account : Equatable{
    
    
    
    var accountData : AccountData
    var transactions = [Transaction]()
    var item : ItemData
    
    init(accountData: AccountData, item: ItemData){
        self.accountData = accountData
        self.item = item
    }
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        
        if lhs.accountData.accountId == rhs.accountData.accountId{
            return true
        }
        return false
        
    }
    
    
    
}
