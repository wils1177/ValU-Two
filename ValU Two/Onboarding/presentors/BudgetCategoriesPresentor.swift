//
//  BudgetCategoriesPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct BudgetCategoryViewData : Hashable {
    let sectionTitle : String
    let icon: String
    let amountSpent: String
    let categories : [String]
}

class BudgetCardsPresentor : Presentor {
    
    var viewData : [BudgetCategoryViewData]?
    var categoryList : CategoryList?
    var selectedCategoryNames = [String]()
    var budget : Budget
    var coordinator : BudgetCategoriesDelegate?
    var allSpendingCategories = [SpendingCategory]()
    

    init (budget: Budget){
        self.budget = budget
        let categoryData = CategoriesData()
        self.categoryList = categoryData.getCategoriesList()
        generateAllSpendingCategories()
        self.viewData = generateViewModels()
        
    }

    func configure() -> UIViewController {
        
        let cardsVC = UIHostingController(rootView: SelectCategoriesView(presentor: self, viewData: self.viewData!))
        return cardsVC
    }
    
    func generateAllSpendingCategories(){
        
        //Create spendingCategories for all of second level subCategories
        for category in self.categoryList!.categories{
            if category.subCategories != nil{
                createSpendingCategories(categories: category.subCategories!)
            }
        }
        
        //Create 'Other' category
        let otherCategory = CategoryEntry(name: SpendingCategoryNames.other.rawValue, contains: ["other"], icon: "✨", subCategories: [CategoryEntry]())
        let otherSpendingCategory = DataManager().createNewSpendingCategory(categoryEntry: otherCategory)
        self.allSpendingCategories.append(otherSpendingCategory)
        
        //Update spending for the categories
        TransactionProccessor().updateInitialThiryDaysSpent(spendingCategories: self.allSpendingCategories)
        
    }
    
    func createSpendingCategories(categories: [CategoryEntry]){
                
        for category in categories{
            let newSpendingCategory = DataManager().createNewSpendingCategory(categoryEntry: category)
            
            //Append to final result of all spending categories
            self.allSpendingCategories.append(newSpendingCategory)
            
        }
    }
    
    
    
    func generateViewModels() -> [BudgetCategoryViewData]{
        
        
        var viewData = [BudgetCategoryViewData]()
        
        for category in self.categoryList!.categories{
                        
            let sectionTitle = category.name
            var subCategoryTitles = [String]()
            let icon = category.icon ?? "❓"
            if category.subCategories != nil{
                
                for subCategory in category.subCategories!{
                    subCategoryTitles.append(subCategory.name)
                }
                
            }
            
            
            var amountSpent = Float(0.0)
            for subCategory in category.subCategories!{
                for spendingCategory in self.allSpendingCategories{
                    if spendingCategory.category?.name == subCategory.name{
                        amountSpent = amountSpent + spendingCategory.initialThirtyDaysSpent
                    }
                }
            }
            
            let amountSpentString = String(format: "$%.02f", amountSpent)
            
            
            viewData.append(BudgetCategoryViewData(sectionTitle: sectionTitle, icon: icon, amountSpent: amountSpentString, categories: subCategoryTitles))
            
        }
        
        return viewData
    }
    
    func selectedCategoryName(name:String){
        
        self.selectedCategoryNames.append(name)
        
    }
    
    func deSelectedCategoryName(name:String){
        self.selectedCategoryNames.removeAll { $0 == name }
    }
    

    
    func submit(){
        
        
        var newSpendingCategoriesList = [SpendingCategory]()
        self.budget.spendingCategories = NSOrderedSet(array: newSpendingCategoriesList)
        

        
        for spendingCategory in self.allSpendingCategories{
            
            for name in self.selectedCategoryNames{
                if name == spendingCategory.category?.name!{
                    newSpendingCategoriesList.append(spendingCategory)
                }
            }
            
            if spendingCategory.category!.name == SpendingCategoryNames.other.rawValue{
                newSpendingCategoriesList.append(spendingCategory)
            }

        }
        
                
        for category in newSpendingCategoriesList{
            self.budget.addToSpendingCategories(category)
        }
        
        //Update the transaction assignments for the categories
        self.budget.updateSpendingAmounts()
        
        self.coordinator?.categoriesSubmitted()
        
    }
    
    

}



