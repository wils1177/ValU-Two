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

class EditCategoryViewModel: CategoryListViewModel, UserSubmitViewModel, ObservableObject {
    
    var viewData = [BudgetCategoryViewData]()
    var selectedCategoryNames = [String]()
    var spendingCategories = [SpendingCategory]()
    var saveRule : Bool = true
    @Published var selectedButtons = [CategoryButton]()
    
    var transaction : Transaction

    init(transaction: Transaction){
        self.transaction = transaction
        getSpendingCategories()
        setupInitialSelectedCategories()
        generateViewData()
        getSelectedButtons()
        
    }
    
    func setupInitialSelectedCategories(){
        
        for category in self.transaction.categoryMatches?.allObjects as! [Category]{
            self.selectedCategoryNames.append(category.name!)
        }
        
    }
    
    
    func submit() {
        
        // Get rid of any removed categories
        let transactionCategoryList = self.transaction.categoryMatches?.allObjects as! [Category]
        for category in transactionCategoryList{
            if !selectedCategoryNames.contains(category.name!){
                self.transaction.removeFromCategoryMatches(category)
            }
        }
        
        //Now add all new categories
        for spendingCategory in self.spendingCategories{
            
            let categoryName = spendingCategory.category!.name!
            let category = spendingCategory.category
            
            if self.selectedCategoryNames.contains(categoryName){
                self.transaction.addToCategoryMatches(category!)
            }
            
            for subSpendingCategory in spendingCategory.subSpendingCategories?.allObjects as! [SpendingCategory]{
                let categoryName = subSpendingCategory.category!.name!
                let category = subSpendingCategory.category
                
                if self.selectedCategoryNames.contains(categoryName){
                    self.transaction.addToCategoryMatches(category!)
                }
                
                subSpendingCategory.reCalculateAmountSpent()
            }
            
            spendingCategory.reCalculateAmountSpent()
            
        }
        
        DataManager().saveDatabase()
        NotificationCenter.default.post(name: .modelUpdate, object: nil)
        
    }
    
    func createTransactionRule(){
        
        let categories = self.transaction.categoryMatches
        let name = self.transaction.name
        
        do{
            //Check for existing rule
            let rule = try DataManager().getTransactionRules(name: name!)
            if rule != nil{
                rule!.name = name
                rule!.categoriesOverride = categories
            }
            //If there is no existing rule, just make a new one
            else{
                _ = DataManager().saveTransactionRule(name: name!, amountOverride: Float(0.0), categoryOverride: categories?.allObjects as! [Category])
                
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
