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
    
    var coordinator : BudgetEditableCoordinator?
    
    @Published var willBeRecurring : Bool = false
    
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
        let budget = budgetSection.budget!
        let budgetCategories = spendingCategory.budgetCategory?.allObjects as! [BudgetCategory]
        let reduandantBudgetCategory = checkIfCategoryAlreadyExistsInBudget(budgetCategories: budgetCategories, budget: budget)
        if reduandantBudgetCategory != nil{
            deleteBudgetCategory(category: reduandantBudgetCategory!)
        }
        
        
        let dm = DataManager()
        let BC = dm.createBudgetCategory(category: spendingCategory, order: self.budgetSection.budgetCategories!.count)
        BC.recurring = self.willBeRecurring
        self.budgetSection.addToBudgetCategories(BC)
        dm.saveDatabase()
    }
    
    
    //Check to see if any of the categories already exist in the Budget
    func checkIfCategoryAlreadyExistsInBudget(budgetCategories: [BudgetCategory], budget: Budget) -> BudgetCategory?{
        for budgetCategory in budgetCategories{
            if budgetCategory.budgetSection?.budget?.id == budget.id{
                return budgetCategory
            }
        }
        return nil
    }
    
    func deleteBudgetCategory(category: BudgetCategory){
        let id = category.id!
        
        let predicate = PredicateBuilder().generateByIdPredicate(id: id)
        do{
            try DataManager().deleteEntity(predicate: predicate, entityName: "BudgetCategory")
        }
        catch{
            print("WARNING: Could delete budget category entity")
        }
        
    }
    
    

    
    func createCustomSpendingCategory(icon: String, name: String){
        let newCategory = spendingCategoryService.createCustomSpendingCategory(icon: icon, name: name)
        
        
        self.spendingCategoryService.loadCategories()
        
        self.parentSpendingCategories = self.spendingCategoryService.getParentSpendingCategories()
        self.childSpendingCategories = self.spendingCategoryService.getSubSpendingCategories()
        
        self.parentSpendingCategories.sort(by: { $0.name! < $1.name! })
        
        
        self.selectedCategoryName(name: newCategory.name!)
        self.submit()
        
        
        self.objectWillChange.send()
        
        self.coordinator?.dismissPresented()
    }
    
    func hide(category: SpendingCategory) {
        print(category.hidden)
        print("hiding the spending category")
        category.hidden = true
        DataManager().saveDatabase()
        self.objectWillChange.send()
    }
    
    
}
