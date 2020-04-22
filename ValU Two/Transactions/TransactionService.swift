//
//  TransactionService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class TransactionService{
    
    var transaction : Transaction
    
    init(transaction: Transaction){
        self.transaction = transaction
    }
    
    
    func getIcons(categories: [CategoryMatch]) -> [String]{
        
        var icons = [String]()
        if categories.count == 0{
            icons.append("❓")
            return icons
        }
        for match in categories{
            if match.spendingCategory!.subSpendingCategories!.count == 0{
                icons.append(match.spendingCategory!.icon!)
            }
        }
        
        return icons
        
    }
    
    func getCategoryName(categories: [CategoryMatch]) -> String{
        if categories.count == 0{
            return "Other"
        }
        else if categories.count == 1{
            return categories.first!.spendingCategory!.name!
        }
        else{
            return "Multiple Categories"
        }
    }
    
}
