//
//  SuggestedCategoryPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI


class SuggestedCategoryViewData : Hashable{
    var categoryButton : CategoryButton
    var amountSpent : String
    var hash = UUID()
    
    init(categoryButton: CategoryButton, amountSpent : String){
        self.categoryButton = categoryButton
        self.amountSpent = amountSpent
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(hash)

    }
    
    static func == (lhs: SuggestedCategoryViewData, rhs: SuggestedCategoryViewData) -> Bool {
        return lhs.hash == rhs.hash
    }
}


class SuggestedCategoryPresentor : Presentor, CategorySelecter{
    
    var budget: Budget?
    var coordinator : OnboardingFlowCoordinator?
    var viewData = [SuggestedCategoryViewData]()
    var selectedCategoryNames = [String]()
    var spendingCategories = [SpendingCategory]()
    weak var delegate : CategoryPickerPresentor?
    
    init(budget: Budget){
        self.budget = budget
        getSuggestedSpendingCategories()
        setInitialCategories()
    }
    
    func configure() -> UIViewController {
        
        generateViewData()
        return UIHostingController(rootView: SuggestedCategoryCard(viewModel: self))
        
        
    }
    
    func setInitialCategories(){
        for category in self.spendingCategories{
            if category.selected{
                selectedCategoryNames.append(category.name!)
            }
        }
    }
    
    func generateViewData(){
        
        
        for category in self.spendingCategories{
            let amount = category.initialThirtyDaysSpent
            let amountString = "$" + String(Int(round(amount)))
            let button = CategoryButton(name: category.name!, icon: category.icon!, selected: category.selected)
            
            let viewDataEntry = SuggestedCategoryViewData(categoryButton: button, amountSpent: amountString)
            self.viewData.append(viewDataEntry)
            
        }
        
    }
    
    func getSuggestedSpendingCategories(){
        
        let allCategories = self.budget!.getSubSpendingCategories()
        
        for category in allCategories{
            if category.initialThirtyDaysSpent > 0.0{
                self.spendingCategories.append(category)
            }
        }
        
        
    }
    

    
    func submit(){
        for spendingCategory in self.spendingCategories{
            if self.selectedCategoryNames.contains(spendingCategory.name!){
                spendingCategory.selected = true
            }
            else{
                spendingCategory.selected = false
            }
            
        }
        
        DataManager().saveDatabase()
        self.delegate!.submit()
        
    }
    

    
}
