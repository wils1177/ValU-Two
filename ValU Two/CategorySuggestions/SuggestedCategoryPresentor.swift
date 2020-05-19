//
//  SuggestedCategoryPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI





class SuggestedCategoryPresentor : Presentor{
    
    
    var budget: Budget?
    var coordinator : OnboardingFlowCoordinator?
    var selectedCategories = [SpendingCategory]()
    var spendingCategories = [SpendingCategory]()
    weak var delegate : CategoryPickerPresentor?
    
    init(budget: Budget){
        self.budget = budget
        getSuggestedSpendingCategories()
        setInitialCategories()
    }
    
    func configure() -> UIViewController {
        
        return UIHostingController(rootView: SuggestedCategoryCard(viewModel: self))

    }
    
    func setInitialCategories(){
        for category in self.spendingCategories{
            if category.selected{
                selectedCategories.append(category)
            }
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

        
        DataManager().saveDatabase()
        self.delegate!.submit()
        
    }
    

    
}
