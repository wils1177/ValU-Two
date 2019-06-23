//
//  SpendingCategory.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

class SpendingCategory{
    
    var name: String
    var limit: Float
    var amontSpent: Float
    
    init(name: String, limit: Float, amountSpent: Float){
        
        self.name = name
        self.limit = limit
        self.amontSpent = amountSpent
        
    }
    
    func getName() -> String{
        return self.name
    }
    
    func setLimit(amount: Float){
        self.limit = amount
    }
    
    func setName(name: String){
        self.name = name
    }
    
    

}
