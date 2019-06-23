//
//  Account.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/13/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

class Account{
    
    var name : String
    var accountId: String
    var type: String
    var subType: String
    var institution: String
    
    init(name: String, accountId: String, type: String, subType: String, instituion: String){
        self.name = name
        self.accountId = accountId
        self.type = type
        self.subType = subType
        self.institution = instituion
    }
    
    
}
