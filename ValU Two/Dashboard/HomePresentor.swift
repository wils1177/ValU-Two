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

struct BudgetCardViewData{
    var income : String
    var spent : String
}

class HomePresentor : Presentor {
    
    var budget : Budget
    
    init(budget : Budget){
        self.budget = budget
    }
    
    func configure() -> UIViewController {
        
        let vc = UIHostingController(rootView: SwiftUITestView(viewData: self.generateViewData()))
        return vc

    }
    
    func generateViewData() -> BudgetCardViewData{
        
        let income = "$" + String(self.budget.amount)
        let spent = "$400.00"
        
        return BudgetCardViewData(income: income, spent: spent)
    }
    
}
