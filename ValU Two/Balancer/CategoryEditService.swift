//
//  CategoryEditService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class CategoryEditService : ObservableObject, KeyboardDelegate{
    
    var budgetCategory : BudgetCategory
    var parentService : BalanceParentService
    @Published var editText : String = ""
    
    init(budgetCategory: BudgetCategory, parentService: BalanceParentService){
        self.budgetCategory = budgetCategory
        self.parentService = parentService
        
        if budgetCategory.limit > 0{
            editText = String(Int(budgetCategory.limit))
        }
    }
    
    func onKeyBoardSet(text: String, key: String?) {
        
        if key != nil && text != ""{
            let value = Float(text)
            updateSpendingLimit(value: value!)
        }
        
        
    }
    
    func updateSpendingLimit(value: Float){
        
        budgetCategory.limit = Double(value)
        parentService.objectWillChange.send()
        parentService.parent.budget!.objectWillChange.send()
        DataManager().saveDatabase()
    }
    
    
    
}
