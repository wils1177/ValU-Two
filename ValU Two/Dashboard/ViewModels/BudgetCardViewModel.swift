//
//  BudgetCardPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

struct BudgetCardViewData{
    var remaining : String = ""
    var spent : String = ""
    var title: String = ""
    var percentage: CGFloat = CGFloat(0.0)
}

class BudgetCardViewModel {
    
    var viewData = BudgetCardViewData()
    var budget : Budget
    
    init(budget : Budget){
        self.budget = budget
        self.viewData = generateViewData()
    }
    
    
    func generateViewData() -> BudgetCardViewData{
        
        let available = self.budget.getAmountAvailable()
        let spendValue = self.budget.spent

        let remaining = "$" + String(Int(round(available - spendValue)))
        let spent = "$" + String(Int(round(spendValue)))
        let percentage = CGFloat(spendValue / available)
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        let title = nameOfMonth
        
        return BudgetCardViewData(remaining: remaining, spent: spent, title: title, percentage: percentage)
    }
    
    

}
