//
//  HomePresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/10/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

import UIKit
import SwiftUI

struct HomeViewData{
    var budgetCardViewModel : BudgetCardViewModel
    var spendingCardViewModel : SpendingCardViewModel
}

class HomeViewModel{
    
    
    var budget : Budget
    var viewData : HomeViewData?
    
    init(budget : Budget){
        self.budget = budget
        self.viewData = generateViewData()
    }
    
    func generateViewData()-> HomeViewData{
        
        let budgetcardViewModel = BudgetCardViewModel(budget: self.budget)        
        let spendingCardViewModel = SpendingCardViewModel(budget: self.budget)
        
        let viewData = HomeViewData(budgetCardViewModel: budgetcardViewModel, spendingCardViewModel: spendingCardViewModel)
        
        return viewData

    
    }
    
}
