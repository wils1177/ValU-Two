//
//  AddCategoriesViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/28/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class AddCategoriesViewModel: CategoryListViewModel, ObservableObject{
    
    var parentSpendingCategories : [SpendingCategory]
    var childSpendingCategories : [SpendingCategory]
    var budgetSection : BudgetSection
    var spendingCategoryService = SpendingCategoryService()
    
    @Published var selectedCategories = [String]()
    
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
        
        self.selectedCategories.append(name)
        
    }
    
    func deSelectedCategoryName(name: String) {
        
        self.selectedCategories = self.selectedCategories.filter(){$0 != name}
        
    }
    
    func isSelected(name: String) -> Bool {
        if self.selectedCategories.contains(name) {
            return true
        }
        else{
            return false
        }
    }
    
    func submit() {
        
        for name in self.selectedCategories{
            for spendingCategory in self.childSpendingCategories{
                if spendingCategory.name! == name{
                    
                    //Check to make sure we have not already added it
                    var alreadySelected = false
                    for budgetCategory in self.budgetSection.budgetCategories!.allObjects as! [BudgetCategory]{
                        if budgetCategory.spendingCategory!.name! == name {
                            alreadySelected = true
                        }
                    }
                    
                    //If not go ahead an add it
                    if !alreadySelected{
                       createNewBudgetCategory(spendingCategory: spendingCategory)
                    }
                }
            }
        }
        

        
    }
    
    func createNewBudgetCategory(spendingCategory: SpendingCategory){
        
        //if the spendingcategory already has a budgetCategory, we need to delete it
        if spendingCategory.budgetCategory != nil{
            let budgetCategory = spendingCategory.budgetCategory!
            let id = budgetCategory.id!
            budgetCategory.budgetSection?.removeFromBudgetCategories(budgetCategory)
            let predicate = PredicateBuilder().generateByIdPredicate(id: id)
            do{
                try DataManager().deleteEntity(predicate: predicate, entityName: "BudgetCategory")
            }
            catch{
                print("WARNING: Could delete budget category entity")
            }
        }
        
        let dm = DataManager()
        let BC = dm.createBudgetCategory(category: spendingCategory, order: self.budgetSection.budgetCategories!.count)
        self.budgetSection.addToBudgetCategories(BC)
        dm.saveDatabase()
    }

    
    func createCustomSpendingCategory(icon: String, name: String){
        let newCategory = spendingCategoryService.createCustomSpendingCategory(icon: icon, name: name)
        
        let allCategories = (self.budgetSection.budgetCategories!.allObjects as! [BudgetCategory]).sorted(by: { $0.order < $1.order })
        let order = allCategories.last!.order + 1
        
        let newBudgetCategory = DataManager().createBudgetCategory(category: newCategory, order: Int(order))
        self.budgetSection.addToBudgetCategories(newBudgetCategory)
        
        self.spendingCategoryService.loadCategories()
        
        self.parentSpendingCategories = self.spendingCategoryService.getParentSpendingCategories()
        self.childSpendingCategories = self.spendingCategoryService.getSubSpendingCategories()
        
        self.parentSpendingCategories.sort(by: { $0.name! < $1.name! })
        self.objectWillChange.send()
    }
    
    
}
