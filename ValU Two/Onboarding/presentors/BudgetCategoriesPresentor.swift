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
    let categories : [CategoryButton]
}

class CategoryButton : Hashable, ObservableObject{
    
    
    let name : String
    let icon : String
    @Published var selected: Bool
    
    init(name: String, icon: String, selected: Bool){
        self.name = name
        self.icon = icon
        self.selected = selected
    }
    
    static func == (lhs: CategoryButton, rhs: CategoryButton) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
}

class BudgetCardsPresentor : Presentor, CategoryListViewModel, UserSubmitViewModel {
    
    var viewData = [BudgetCategoryViewData]()
    var selectedCategoryNames = [String]()
    var spendingCategories = [SpendingCategory]()
    
    var coordinator : BudgetCategoriesDelegate?
    var budget : Budget?
    

    init (budget: Budget){
        self.budget = budget
        getSpendingCategories()
        generateViewData()
    }

    func configure() -> UIViewController {
        
        let cardsVC = UIHostingController(rootView: SelectCategoriesView(viewModel: self))
        return cardsVC
    }
    
    func setupInitialSelectedCategories(){
        
        for subCategory in self.budget!.getSubSpendingCategories(){
            if subCategory.selected{
                self.selectedCategoryNames.append(subCategory.name!)
            }
        }
        
    }
    
    
    
    
    
    

    
    func submit(){
        
        for spendingCategory in self.spendingCategories{
            
             if spendingCategory.subSpendingCategories != nil{
                 
                 for case let subSpendingCategory as SpendingCategory in spendingCategory.subSpendingCategories!{
                     
                    if self.selectedCategoryNames.contains(subSpendingCategory.name!){
                        subSpendingCategory.selected = true
                    }
                    else{
                        subSpendingCategory.selected = false
                    }
                    
                 }
                 
             }
            
        }
        
        self.coordinator?.categoriesSubmitted()
        
    }
    
    

}

extension CategoryListViewModel{
    
    func getSpendingCategories(){
        self.spendingCategories = budget!.getParentSpendingCategories()
    }
    
    
    func selectedCategoryName(name:String){
        
        self.selectedCategoryNames.append(name)
        
    }
    
    func deSelectedCategoryName(name:String){
        self.selectedCategoryNames.removeAll { $0 == name }
    }
    
    func generateViewData(){
        
        
        var viewData = [BudgetCategoryViewData]()
        
        for spendingCategory in self.spendingCategories{
            
                        
            let sectionTitle = spendingCategory.name!
            var subCategories = [CategoryButton]()
            let icon = spendingCategory.icon ?? "❓"
            
            let amountSpent = spendingCategory.initialThirtyDaysSpent
            let amountSpentString = String(format: "$%.02f", amountSpent)
                        
            if spendingCategory.subSpendingCategories != nil{
                
                for case let subSpendingCategory as SpendingCategory in spendingCategory.subSpendingCategories!{
                    
                    let name = subSpendingCategory.name!
                    let icon = subSpendingCategory.icon!
                    var selectedDefault = false
                    
                    if self.selectedCategoryNames.contains(name){
                        selectedDefault = true
                    }
                    
                    let newSubCategory = CategoryButton(name: name, icon: icon, selected: selectedDefault)
                    subCategories.append(newSubCategory)
                }
                
            }
            
            viewData.append(BudgetCategoryViewData(sectionTitle: sectionTitle, icon: icon, amountSpent: amountSpentString, categories: subCategories))
            
        }
        
        self.viewData = viewData
    }
    
}



