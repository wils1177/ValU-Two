//
//  CategoryEditService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class CategoryEditService : ObservableObject, KeyboardDelegate{
    
    var spendingCategory : SpendingCategory
    var parentService : BalanceParentService
    @Published var editText : String = ""
    
    init(spendingCategory: SpendingCategory, parentService: BalanceParentService){
        self.spendingCategory = spendingCategory
        self.parentService = parentService
        
        if spendingCategory.limit > 0{
            editText = String(Int(spendingCategory.limit))
        }
    }
    
    func onKeyBoardSet(text: String, key: String?) {
        
        if key != nil && text != ""{
            let value = Float(text)
            updateSpendingLimit(value: value!)
        }
        
        
    }
    
    func updateSpendingLimit(value: Float){
        
        spendingCategory.limit = value
        parentService.objectWillChange.send()
        parentService.parent.budget!.objectWillChange.send()
        DataManager().saveDatabase()
    }
    
    
    
}
