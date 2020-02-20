//
//  EditCategoryViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

struct EditCategoryViewData{
    
    var selectedCategories : [CategoryButton]
    
}

class EditCategoryViewModel: CategoryListViewModel, UserSubmitViewModel, ObservableObject, Presentor {
    
    var coordinator: TransactionRowDelegate?
    
    var viewData = [BudgetCategoryViewData]()
    var selectedCategoryNames = [String]()
    var spendingCategories = [SpendingCategory]()
    var saveRule : Bool = true
    var budget : Budget?
    @Published var selectedButtons = [CategoryButton]()
    
    var transaction : Transaction

    init(transaction: Transaction, budget: Budget){
        self.transaction = transaction
        self.budget = budget
        getSpendingCategories()
        setupInitialSelectedCategories()
        generateViewData()
        getSelectedButtons()
        
    }
    

    
    func configure() -> UIViewController {
        return UIHostingController(rootView: EditCategoriesView(viewModel: self))
    }
    
    func setupInitialSelectedCategories(){
        
        for category in self.transaction.categoryMatches?.allObjects as! [SpendingCategory]{
            self.selectedCategoryNames.append(category.name!)
        }
        
    }
    
    
    func submit() {
        
        
        // Get rid of any removed categories
        let transactionCategoryList = self.transaction.categoryMatches?.allObjects as! [SpendingCategory]
        for category in transactionCategoryList{
            if !selectedCategoryNames.contains(category.name!){
                self.transaction.removeFromCategoryMatches(category)
            }
        }
        
        //Now add all new categories
        for spendingCategory in self.spendingCategories{
            
            let categoryName = spendingCategory.name!
            
            if self.selectedCategoryNames.contains(categoryName){
                self.transaction.addToCategoryMatches(spendingCategory)
            }
            
            for subSpendingCategory in spendingCategory.subSpendingCategories?.allObjects as! [SpendingCategory]{
                let categoryName = subSpendingCategory.name!
                
                if self.selectedCategoryNames.contains(categoryName){
                    self.transaction.addToCategoryMatches(subSpendingCategory)
                }
                
            }
            
            
            
        }
        
        self.budget?.updateAmountSpent()
        
        if saveRule{
            createTransactionRule()
        }
        DataManager().saveDatabase()

        
        NotificationCenter.default.post(name: .modelUpdate, object: nil)
        coordinator?.dismissEditCategory()

    }
    
    func createTransactionRule(){
        
        var categories = [String]()
        for category in transaction.categoryMatches?.allObjects as! [SpendingCategory]{
            categories.append(category.name!)
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
    
    func selectedCategoryName(name:String){
        
        self.selectedCategoryNames.append(name)
        
    }
    
    func deSelectedCategoryName(name:String){
        self.selectedCategoryNames.removeAll { $0 == name }
    }
    
    func getSelectedButtons(){
        self.selectedButtons = [CategoryButton]()
        for categoryCard in viewData{
            for button in categoryCard.categories{
                if button.selected{
                    self.selectedButtons.append(button)
                }
            }
        }
    }

}
