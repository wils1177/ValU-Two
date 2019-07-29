//
//  SpendingCategory.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

class SpendingCategory{
    
    let category: Category
    var limit: Float?
    var amountSpent: Float?
    
    init(category: Category, limit: Float, amountSpent: Float){
        
        self.category = category
        self.limit? = limit
        self.amountSpent? = amountSpent
        
    }
    
    func updateSpendingLimit(newLimit: Float){
        self.limit = newLimit
    }


}
