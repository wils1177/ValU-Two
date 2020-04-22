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
        
        for categoryMatch in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            self.selectedCategoryNames.append(categoryMatch.spendingCategory!.name!)
        }
        
    }
    
    
    func submit() {
        
        ridRemovedCategories()
        addNewCategories()

        self.budget?.updateAmountSpent()
        
        if saveRule{
            createTransactionRule()
        }
        DataManager().saveDatabase()

        
        NotificationCenter.default.post(name: .modelUpdate, object: nil)
        coordinator?.dismissEditCategory()

    }
    
    func ridRemovedCategories(){
        
        // Get rid of any removed categories
        let transactionCategoryList = self.transaction.categoryMatches?.allObjects as! [CategoryMatch]
        for categoryMatch in transactionCategoryList{
            if !selectedCategoryNames.contains(categoryMatch.spendingCategory!.name!){
                let predicate = PredicateBuilder().generateByIdPredicate(id: categoryMatch.id!)
                do{
                    try DataManager().deleteEntity(predicate: predicate, entityName: "CategoryMatch")
                }
                catch{
                    print("Could not remove the category match!!")
                }
            }
        }
        
    }
    
    func addNewCategories(){
        
        //Now add all NEW categories
             for selectedCategoryName in self.selectedCategoryNames{
                 
                 var isNew = true
                 for categoryMatch in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
                     
                     if categoryMatch.spendingCategory!.name == selectedCategoryName{
                         isNew = false
                     }
                     
                 }
                 
                 if isNew{
                    
                    for spendingCategory in self.budget!.getSubSpendingCategories(){
                        if spendingCategory.name! == selectedCategoryName{
                            let categoryMatch = DataManager().createCategoryMatch(transaction: self.transaction, category: spendingCategory, amount: Float(self.transaction.amount))
                            spendingCategory.addToTransactions(self.transaction)
                        }
                    }
                    
                     
                 }
        
             }
        
        
        
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
