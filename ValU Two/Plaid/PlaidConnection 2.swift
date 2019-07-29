//
//  PlaidConnection.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/12/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

class PlaidConnection{
    
    let publicKey : String
    var proccessor : PlaidProccessor
    
    
    init(publicKey: String){
        self.publicKey = publicKey
        self.proccessor = PlaidProccessor()
    }
    
    func aggregateAccounts(response: [String: Any]){
        self.proccessor.aggregateAccounts(response: response)
    }
    
    
    
    
}
