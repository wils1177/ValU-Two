//
//  AccountDetailService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class AccountDetailService{
    
    var account : AccountData
    
    init(account: AccountData){
        self.account = account
    }
    
    func getTransactionsForAccount() -> [Transaction]{
        let accountId = self.account.accountId!
        let query = PredicateBuilder().generateByAccountIdPredicate(id: accountId)
        
        do{
            return try DataManager().getEntity(predicate: query, entityName: "Transaction") as! [Transaction]
        }
        catch{
            return [Transaction]()
        }
        
    }
    
}
