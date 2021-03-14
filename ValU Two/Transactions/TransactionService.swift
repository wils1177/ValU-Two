//
//  TransactionService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class TransactionService{
    
    
    
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
    
    func getAmount(transaction: Transaction) -> String{
        if let categories = transaction.categoryMatches?.allObjects as? [CategoryMatch]{
            var amount = Float(0.0)
            if categories.count > 0{
                for match in categories{
                    amount = amount + match.amount
                }
            }
            else{
                amount = Float(transaction.amount)
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
    
    
    func getBudgetLabels(transaction: Transaction) -> [TransactionBudgetLabelViewData]{
        var results = [TransactionBudgetLabelViewData]()
        let categories = transaction.categoryMatches!.allObjects as! [CategoryMatch]
        
        if transaction.isHidden{
            let moreEntry = TransactionBudgetLabelViewData(name: "Hidden", icon: "eye.circle", color: Color(.lightGray))
            results.append(moreEntry)
            return results
        }
        
        if transaction.amount < 0.0 {
            let moreEntry = TransactionBudgetLabelViewData(name: "Income", icon: "arrow.up.circle.fill", color: Color(.systemGreen))
            results.append(moreEntry)
            return results
        }
        
        let activeBudgetSections = checkForActiveBudgetSection(categories: categories)
        
        if activeBudgetSections.count == 0 {
            let moreEntry = TransactionBudgetLabelViewData(name: "No Budget", icon: "book", color: Color(.lightGray))
            results.append(moreEntry)
            return results
        }
        else if activeBudgetSections.count == 1 {
            let name = activeBudgetSections[0].name!
            let icon = activeBudgetSections[0].icon!
            let color = colorMap[Int((activeBudgetSections[0].colorCode))]
            
            let entry = TransactionBudgetLabelViewData(name: name, icon: icon, color: color)
            results.append(entry)
            return results
        }
        else{
            let name = activeBudgetSections[0].name!
            let icon = activeBudgetSections[0].icon!
            let color = colorMap[Int((activeBudgetSections[0].colorCode))]
            
            let entry = TransactionBudgetLabelViewData(name: name, icon: icon, color: color)
            results.append(entry)
            
            let moreEntry = TransactionBudgetLabelViewData(name: "More", icon: "ellipsis", color: Color(.lightGray))
            results.append(moreEntry)
            return results
            
            return results
            
        }
        
        
    }
    
    //Checks the category matches to see if there are associated active budget sections
    func checkForActiveBudgetSection(categories: [CategoryMatch]) -> [BudgetSection]{
        var activeBudgetSections = [BudgetSection]()
        for category in categories{
            let BudgetCategories = category.spendingCategory?.budgetCategory?.allObjects as! [BudgetCategory]
            
            for budgetCategory in BudgetCategories{
                if budgetCategory.budgetSection!.budget!.active{
                    activeBudgetSections.append(budgetCategory.budgetSection!)
                }
            }
            
        }
        return activeBudgetSections
    }
    
    
    
    
}
