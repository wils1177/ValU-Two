//
//  BalanceParentService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BalanceParentService : ObservableObject, Hashable{
    
    @Published var parent : SpendingCategory
    @Published var children : [SpendingCategory]
    
    var id = UUID()
    
    init(spendingCategory: SpendingCategory){
        self.parent = spendingCategory
        self.children = spendingCategory.subSpendingCategories?.allObjects as! [SpendingCategory]
    }
    
    func getParentLimit() -> Float{
        var total = Float(0.0)
        for child in self.children{
            total = child.limit + total
        }
        return total
    }
    
    func getParentSpent() -> Float{
        var total = Float(0.0)
        for child in self.children{
            
            if child.limit > 0.0{
                total = child.getAmountSpent() + total
            }
            
        }
        return total
    }
    
    func getParentInitialSpent() -> Float{
        var total = Float(0.0)
        for child in self.children{
            
            total = child.initialThirtyDaysSpent + total

        }
        return total
    }
    
    func getPercentageSpent() -> Float{
        let limit = getParentLimit()
        let spent = getParentSpent()
        
        if limit != 0.0{
           return spent / limit
        }
        else{
            return 0.0
        }
        
    }
    
    static func == (lhs: BalanceParentService, rhs: BalanceParentService) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    
}
