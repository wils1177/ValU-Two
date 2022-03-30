//
//  TransactionRuleViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/6/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import Foundation

class TransactionRuleViewModel: CategoryListViewModel, ObservableObject{
    
    @Published var currentName = ""
    
    var transactionRule : TransactionRule?
    
    var coordinator: SettingsFlowCoordinator?
    var spendingCategories = SpendingCategoryService().getSubSpendingCategories()
    
    @Published var selectedCategoryNames = [String]()
    
    init(rule: TransactionRule? = nil){
        self.transactionRule = rule
        
        if transactionRule != nil{
            self.currentName = transactionRule!.name!
            setSelectedCategories()
        }
        
    }
    
    func setSelectedCategories(){
        self.selectedCategoryNames = [String]()
        for category in self.transactionRule!.spendingCategories!.allObjects as! [SpendingCategory]{
            self.selectedCategoryNames.append(category.name!)
        }
    }
    
    
    func selectedCategoryName(name: String) {
        self.selectedCategoryNames.append(name)
    }
    
    func deSelectedCategoryName(name: String) {
        self.selectedCategoryNames.removeAll { $0 == name}
    }
    
    func isSelected(name: String) -> Bool {
        for category in self.selectedCategoryNames{
            if name == category{
                return true
            }
        }
        return false
    }
    
    func deleteRule(id: UUID){
        
        
        
        do{
            try DataManager().deleteEntity(predicate: PredicateBuilder().generateByIdPredicate(id: id), entityName: "TransactionRule")
        }
        catch{
            print("Could not delete the transaction rule!")
        }
        
        self.coordinator?.dismissTransactionDetail()
        
    }
    
    func submit() {
        
        
        
        
        var setOfCategories = NSSet()
        for category in self.spendingCategories{
            for name in selectedCategoryNames{
                if category.name! == name{
                    setOfCategories = setOfCategories.adding(category) as NSSet
                }
            }
        }
        
        if self.transactionRule != nil{
            self.transactionRule!.name = self.currentName
            
            
            self.transactionRule!.spendingCategories = setOfCategories
        }
        else{
            let newRule = DataManager().saveTransactionRule(name: currentName, amountOverride: Float(0.0), categoryOverride: [String]())
            newRule.spendingCategories = setOfCategories
        }
        
        
        
        
        DataManager().saveDatabase()
        
        self.coordinator?.dismissTransactionDetail()
        
    }
    
    
    
    
}
