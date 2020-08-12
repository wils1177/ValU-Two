//
//  AddCategoriesViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/28/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class AddCategoriesViewModel: CategoryListViewModel{
    
    var parentSpendingCategories : [SpendingCategory]
    var childSpendingCategories : [SpendingCategory]
    var budgetSection : BudgetSection
    var spendingCategoryService = SpendingCategoryService()
    
    var selectedCategories = [BudgetCategory]()
    
    init(budgetSection: BudgetSection){
        self.budgetSection = budgetSection
        self.parentSpendingCategories = self.spendingCategoryService.getParentSpendingCategories()
        self.childSpendingCategories = self.spendingCategoryService.getSubSpendingCategories()
        self.parentSpendingCategories.sort(by: { $0.name! < $1.name! })
    }
    
    func getAllCurrentlySelected() -> [SpendingCategory]{
        return [SpendingCategory]()
    }
    
    
    func selectedCategoryName(name: String) {
        
        for spendingCategory in self.childSpendingCategories{
            if spendingCategory.name! == name{
                let newBudgetCategory = DataManager().createBudgetCategory(category: spendingCategory)
                self.selectedCategories.append(newBudgetCategory)
                spendingCategory.objectWillChange.send()
                self.objectWillChange.send()
            }
        }
        
    }
    
    func deSelectedCategoryName(name: String) {
        
        for category in self.selectedCategories{
            if category.spendingCategory!.name! == name{
                
                if let index = self.selectedCategories.firstIndex(of: category) {
                    self.selectedCategories.remove(at: index)
                }
                
                let predicate = PredicateBuilder().generateByIdPredicate(id: category.id!)
                category.spendingCategory!.objectWillChange.send()
                self.objectWillChange.send()
                do{
                    try DataManager().deleteEntity(predicate: predicate, entityName: "BudgetCategory")
                }
                catch{
                    print("WARNING: Could not delete budget category entity")
                }
            
                
            }
        }
        
    }
    
    func isSelected(name: String) -> Bool {
        for category in self.selectedCategories{
            if category.spendingCategory!.name! == name{
                return true
            }
        }
        return false
    }
    
    func submit() {
        
        for category in self.selectedCategories{
            self.budgetSection.addToBudgetCategories(category)
        }
        
    }
    
    func createCustomSpendingCategory(icon: String, name: String){
        let newCategory = spendingCategoryService.createCustomSpendingCategory(icon: icon, name: name)
        
        let newBudgetCategory = DataManager().createBudgetCategory(category: newCategory)
        self.budgetSection.addToBudgetCategories(newBudgetCategory)
        
        self.spendingCategoryService.loadCategories()
        
        self.parentSpendingCategories = self.spendingCategoryService.getParentSpendingCategories()
        self.childSpendingCategories = self.spendingCategoryService.getSubSpendingCategories()
        
        self.parentSpendingCategories.sort(by: { $0.name! < $1.name! })
    }
    
    
}
