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





class BudgetCardsPresentor : Presentor, CategoryListViewModel, UserSubmitViewModel {
    
    var selectedCategoryNames = [String]()
    var spendingCategories = [SpendingCategory]()
    
    var coordinator : BudgetCategoriesDelegate?
    var budget : Budget?
    var delegate : CategoryPickerPresentor?
    

    init (budget: Budget){
        self.budget = budget
        self.spendingCategories = self.budget!.getParentSpendingCategories()
        setupInitialSelectedCategories()
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
        
        DataManager().saveDatabase()
        self.delegate?.submit()
        
    }
    
    
    
    

}





