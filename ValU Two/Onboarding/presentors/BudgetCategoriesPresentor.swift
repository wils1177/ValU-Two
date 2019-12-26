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
    let categories : [String]
}

class BudgetCardsPresentor : Presentor {
    
    var viewData : [BudgetCategoryViewData]?
    var categoryList : CategoryList?
    var selectedCategoryNames = [String]()
    var budget : Budget
    var coordinator : BudgetCategoriesDelegate?
    

    init (budget: Budget){
        self.budget = budget
        self.viewData = generateViewModels()
    }

    func configure() -> UIViewController {
        
        let cardsVC = UIHostingController(rootView: SelectCategoriesView(presentor: self, viewData: self.viewData!))
        return cardsVC
    }
    
    func generateViewModels() -> [BudgetCategoryViewData]{
        
        let categoryData = CategoriesData()
        self.categoryList = categoryData.getCategoriesList()
        var viewData = [BudgetCategoryViewData]()
        
        for category in self.categoryList!.categories{
            let sectionTitle = category.name
            var subCategoryTitles = [String]()
            if category.subCategories != nil{
                
                for subCategory in category.subCategories!{
                    subCategoryTitles.append(subCategory.name)
                }
                
            }
            
            viewData.append(BudgetCategoryViewData(sectionTitle: sectionTitle, categories: subCategoryTitles))
            
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
        
        for name in self.selectedCategoryNames{
            let category = self.categoryList?.getCategoryByName(name: name)
            let newSpendingCategory = DataManager().createNewSpendingCategory(categoryEntry: category!)
            newSpendingCategoriesList.append(newSpendingCategory)
        }
        
        
        //Create 'Other' category
        let otherCategory = CategoryEntry(name: "Other", contains: [String](), subCategories: [CategoryEntry]())
        let otherSpendingCategory = DataManager().createNewSpendingCategory(categoryEntry: otherCategory)
        //otherSpendingCategory.limit = self.budget.getAmountAvailable()
        newSpendingCategoriesList.append(otherSpendingCategory)
        
                
        for category in newSpendingCategoriesList{
            self.budget.addToSpendingCategories(category)
        }
        
        self.coordinator?.categoriesSubmitted()
        
    }
    
    

}



