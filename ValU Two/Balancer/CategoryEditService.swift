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
    @Published var editText : String = ""
    
    var viewModel: BudgetBalancerPresentor
    
    init(budgetCategory: BudgetCategory, viewModel: BudgetBalancerPresentor){
        self.budgetCategory = budgetCategory
        self.viewModel = viewModel
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
        DataManager().saveDatabase()
        self.budgetCategory.budgetSection?.objectWillChange.send()
        self.viewModel.budget.objectWillChange.send()
    }
    
    
    
}
