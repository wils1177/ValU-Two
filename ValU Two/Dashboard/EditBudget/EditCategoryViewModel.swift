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
    
    var selectedCategoryNames = [String]()
    var spendingCategories = [SpendingCategory]()
    var subSpendingCategories = [SpendingCategory]()
    var saveRule : Bool = true
    
    var transaction : Transaction

    init(transaction: Transaction){
        self.transaction = transaction
        self.spendingCategories = SpendingCategoryService().getParentSpendingCategories()
        self.subSpendingCategories = SpendingCategoryService().getSubSpendingCategories()
        
    }
    

    
    func configure() -> UIViewController {
        return UIHostingController(rootView: EditCategoriesView(viewModel: self))
    }
    

    
    
    func submit() {
        
        if saveRule{
            createTransactionRule()
        }
        DataManager().saveDatabase()
        
        NotificationCenter.default.post(name: .modelUpdate, object: nil)
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
    
    func selectedCategoryName(name:String){
        
        
        for spendingCategory in self.subSpendingCategories{
            if spendingCategory.name! == name{
                
                var amount = 0.0
                if self.transaction.categoryMatches?.allObjects.count == 0{
                    amount = transaction.amount
                }
                print("added!")
                let categoryMatch = DataManager().createCategoryMatch(transaction: self.transaction, category: spendingCategory, amount: Float(amount))
                spendingCategory.addToTransactions(self.transaction)
                DataManager().saveDatabase()
                spendingCategory.objectWillChange.send()
                transaction.objectWillChange.send()
            }
        }
        
        if saveRule{
            createTransactionRule()
        }
        
    }
    
    func deSelectedCategoryName(name:String){
        for match in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            if match.spendingCategory!.name == name{
                let predicate = PredicateBuilder().generateByIdPredicate(id: match.id!)
                
                do{
                    
                    try DataManager().deleteEntity(predicate: predicate, entityName: "CategoryMatch")
                    print("removed!")
                    
                    DataManager().saveDatabase()
                    self.objectWillChange.send()
                    transaction.objectWillChange.send()
                }
                catch{
                    print("Could not remove the category match!!")
                }
            }
        }
        
        if saveRule{
            createTransactionRule()
        }
        
    }
    
    func isSelected(name: String) -> Bool{
        for match in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            if match.spendingCategory!.name == name{
                return true
            }
        }
        return false
    }
    
    func dismiss(){
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
