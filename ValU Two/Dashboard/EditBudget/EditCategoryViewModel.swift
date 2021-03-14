//
//  EditCategoryViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI



class EditCategoryViewModel: CategoryListViewModel, UserSubmitViewModel, ObservableObject, Presentor {
    
    var coordinator: TransactionRowDelegate?
    
    @Published var selectedCategoryNames = [String]()
    var spendingCategories = [SpendingCategory]()
    var subSpendingCategories = [SpendingCategory]()
    var saveRule : Bool = false
    
    var budgetSections = [BudgetSection]()
    var unassignedBudgetCategories = [SpendingCategory]()
    
    var transaction : Transaction
    
    var budget : Budget?

    init(transaction: Transaction, budget : Budget? = nil){
        self.transaction = transaction
        self.budget = budget
        self.spendingCategories = SpendingCategoryService().getParentSpendingCategories()
        self.subSpendingCategories = SpendingCategoryService().getSubSpendingCategories()
        self.budgetSections = budget?.getBudgetSections() ?? [BudgetSection]()
        self.unassignedBudgetCategories = self.parentCategoriesToUnassignedCategories(parentCategories: self.spendingCategories)
        DataManager().saveDatabase()
        
    }
    
    
    func configure() -> UIViewController {
        
        return UIHostingController(rootView: EditCategoriesView(viewModel: self))
    }
    
    func removeAllExistingCategories(){
        for match in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            
            if !self.selectedCategoryNames.contains(match.spendingCategory!.name!){
                let predicate = PredicateBuilder().generateByIdPredicate(id: match.id!)
                
                do{
                    
                    try DataManager().deleteEntity(predicate: predicate, entityName: "CategoryMatch")
                    print("removed!")
                    
                    //DataManager().saveDatabase()
                    //self.objectWillChange.send()
                    //transaction.objectWillChange.send()
                }
                catch{
                    print("Could not remove the category match!!")
                }

            }
            
        }
    }

    
    
    func submit() {
        
        self.removeAllExistingCategories()
        for name in self.selectedCategoryNames{
            self.addCategory(name: name)
        }
        
        
        if saveRule{
            createTransactionRule()
        }
        
        DataManager().saveDatabase()
        self.budget?.objectWillChange.send()
        self.transaction.objectWillChange.send()
        
        
        
        
        coordinator?.dismissEditCategory()

    }
    

    
    func createTransactionRule(){
        
        var categories = [String]()
        for match in transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            categories.append(match.spendingCategory!.name!)
        }
        let name = self.transaction.name
        
        do{
            //Check for existing rule
            let rule = try DataManager().getTransactionRules(name: name!)
            if rule != nil{
                rule!.name = name
                rule!.categories = categories
            }
            //If there is no existing rule, just make a new one
            else{
                _ = DataManager().saveTransactionRule(name: name!, amountOverride: Float(0.0), categoryOverride: categories)
                
            }
            
        }
        catch{
            print("Could not create transaction rule!!")
        }
        
        
    }
    
    
    func addCategory(name: String){
        for spendingCategory in self.subSpendingCategories{
            if spendingCategory.name! == name{
                
                var amount = 0.0
                if self.transaction.categoryMatches?.allObjects.count == 0{
                    amount = transaction.amount
                }
                print("added!")
                let categoryMatch = DataManager().createCategoryMatch(transaction: self.transaction, category: spendingCategory, amount: Float(amount))
                spendingCategory.addToTransactions(self.transaction)
                //DataManager().saveDatabase()
                //spendingCategory.objectWillChange.send()
                //transaction.objectWillChange.send()
            }
        }
    }
    
    func removeCategory(name: String){
        
        for match in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            if match.spendingCategory!.name == name{
                let predicate = PredicateBuilder().generateByIdPredicate(id: match.id!)
                
                do{
                    
                    try DataManager().deleteEntity(predicate: predicate, entityName: "CategoryMatch")
                    print("removed!")
                    
                    //DataManager().saveDatabase()
                    //self.objectWillChange.send()
                    //transaction.objectWillChange.send()
                }
                catch{
                    print("Could not remove the category match!!")
                }
            }
        }
        
    }
    
    func selectedCategoryName(name:String){
        
        self.selectedCategoryNames.append(name)
        
        
    }
    
    func deSelectedCategoryName(name:String){
        
        
        self.selectedCategoryNames = self.selectedCategoryNames.filter(){$0 != name}
        
    }
    
    func parentCategoriesToUnassignedCategories(parentCategories: [SpendingCategory]) -> [SpendingCategory]{
        var newList = [SpendingCategory]()
        for parent in parentCategories{
            for subCategory in parent.subSpendingCategories!.allObjects as! [SpendingCategory]{
                if checkForActiveBudgetSection(category: subCategory).count == 0{
                    newList.append(subCategory)
                }
            }
        }
        return newList
    }
    
    //Checks the category matches to see if there are associated active budget sections
    func checkForActiveBudgetSection(category: SpendingCategory) -> [BudgetSection]{
        var activeBudgetSections = [BudgetSection]()
        
        let BudgetCategories = category.budgetCategory?.allObjects as! [BudgetCategory]
        
        for budgetCategory in BudgetCategories{
            if budgetCategory.budgetSection!.budget!.active{
                activeBudgetSections.append(budgetCategory.budgetSection!)
            }
        }
        

        return activeBudgetSections
    }
    
    func isSelected(name: String) -> Bool{
        
        if self.selectedCategoryNames.contains(name) {
            return true
        }
        else{
            return false
        }
        
        /*
        for match in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            if match.spendingCategory!.name == name{
                return true
            }
        }
        return false
        */
    }
    
    func dismiss(){
        self.selectedCategoryNames = [String]()
        self.coordinator?.dismissEditCategory()
    }
    
    func clearSelected(){
        
        for match in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
                let predicate = PredicateBuilder().generateByIdPredicate(id: match.id!)
                do{
                    
                    try DataManager().deleteEntity(predicate: predicate, entityName: "CategoryMatch")
                    print("removed!")

                    DataManager().saveDatabase()
                    self.objectWillChange.send()
                }
                catch{
                    print("Could not remove the category match!!")
                }
            
        }
        
    }
    


}
