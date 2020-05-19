//
//  CategoryPickerPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

struct CategoryPickerViewData{
    var budgetCategoriesPresentor : BudgetCardsPresentor
    var suggestedCategoryPresentor : SuggestedCategoryPresentor
}

class CategoryPickerPresentor {
    
    var budget: Budget
    var coordinator : OnboardingFlowCoordinator?
    var viewData : CategoryPickerViewData?
    weak var delegate : BudgetBalancerPresentor?
    
    init(budget: Budget){
        self.budget = budget
    }
    

    
    func generateViewData(){
        let budgetCards = BudgetCardsPresentor(budget: self.budget)
        budgetCards.delegate = self
        
        let suggestedCard = SuggestedCategoryPresentor(budget: self.budget)
        suggestedCard.delegate = self
        
        self.viewData = CategoryPickerViewData(budgetCategoriesPresentor: budgetCards, suggestedCategoryPresentor: suggestedCard)
    }
    
    func submit(){
    }
    
    
    

    
}
