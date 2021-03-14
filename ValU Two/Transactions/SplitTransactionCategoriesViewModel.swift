//
//  SplitTransactionCategoriesViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class SplitTransactionCategoryViewModel: CategoryListViewModel, UserSubmitViewModel, ObservableObject, Presentor{
    
    var coordinator: TransactionRowDelegate?
    
    @Published var selectedCategoryNames = [String]()
    var spendingCategories = [SpendingCategory]()
    var subSpendingCategories = [SpendingCategory]()
    
    var budgetSections = [BudgetSection]()
    var unassignedBudgetCategories = [SpendingCategory]()
    
    var transaction : Transaction
    
    init(transaction: Transaction, budget : Budget? = nil){
        self.transaction = transaction
        self.spendingCategories = SpendingCategoryService().getParentSpendingCategories()
        self.subSpendingCategories = SpendingCategoryService().getSubSpendingCategories()
        self.budgetSections = budget?.getBudgetSections() ?? [BudgetSection]()
        self.unassignedBudgetCategories = self.parentCategoriesToUnassignedCategories(parentCategories: self.spendingCategories)
        DataManager().saveDatabase()
        
    }
    
    
    func selectedCategoryName(name: String) {
        self.selectedCategoryNames.append(name)
    }
    
    func deSelectedCategoryName(name: String) {
        self.selectedCategoryNames = self.selectedCategoryNames.filter(){$0 != name}
    }
    
    func isSelected(name: String) -> Bool {
        if self.selectedCategoryNames.contains(name) {
            return true
        }
        else{
            return false
        }
    }
    
    func submit() {
        for name in self.selectedCategoryNames{
            self.addCategory(name: name)
        }
        
        DataManager().saveDatabase()
        self.objectWillChange.send()
        transaction.objectWillChange.send()
        
        NotificationCenter.default.post(name: .modelUpdate, object: nil)
        coordinator?.dismissEditCategory()
    }
    
    func configure() -> UIViewController {
        return UIHostingController(rootView: SplitTransactionCategoriesView(viewModel: self))
    }
    
    func addCategory(name: String){
        
        //Check first that cateogry isn't already there
        
        for match in transaction.categoryMatches!.allObjects as! [CategoryMatch]{
            if match.spendingCategory!.name! == name{
                return
            }
        }
        
        
        for spendingCategory in self.subSpendingCategories{
            if spendingCategory.name! == name{
                
                var amount = 0.0
                
                print("added!")
                let categoryMatch = DataManager().createCategoryMatch(transaction: self.transaction, category: spendingCategory, amount: Float(amount))
                spendingCategory.addToTransactions(self.transaction)
                //DataManager().saveDatabase()
                //spendingCategory.objectWillChange.send()
                //transaction.objectWillChange.send()
            }
        }
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
    
    func dismiss(){
        self.selectedCategoryNames = [String]()
        self.coordinator?.dismissEditCategory()
    }
    
}
