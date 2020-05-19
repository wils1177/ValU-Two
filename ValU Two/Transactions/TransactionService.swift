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
    
    func getAmount() -> String{
        if let categories = self.transaction.categoryMatches?.allObjects as? [CategoryMatch]{
            var amount = Float(0.0)
            if categories.count > 0{
                for match in categories{
                    amount = amount + match.amount
                }
            }
            else{
                amount = Float(self.transaction.amount)
            }
            return getPresentationAmount(amount: Double(amount))
        }
        else{
            return " "
        }
        
        
        
        
        
    }
    
    func getPresentationAmount(amount : Double) -> String{
        

        if amount > 0 && amount < 100{
            return String(format: "-$%.02f", amount)
        }
        else if amount > 0 && amount > 100{
            return String(format: "-$%.f", amount)
        }
        else if amount < 0 && (amount * -1) > 100{
                return String(format: "+$%.f", (amount * -1))
        }
        else{
            return String(format: "+$%.02f", (amount * -1))
        }
    }
    
}
