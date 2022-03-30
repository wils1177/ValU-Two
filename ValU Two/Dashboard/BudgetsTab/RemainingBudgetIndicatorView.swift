//
//  RemainingBudgetIndicatorView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/16/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct RemainingBudgetIndicatorView: View {
    
    var viewModel : BudgetsViewModel
    @ObservedObject var budget : Budget
    
    init(viewModel : BudgetsViewModel, budget: Budget){
        self.viewModel = viewModel
        self.budget = budget
    }
    
    func getRemainingDisplayText() -> String {
        let remaining = self.viewModel.getRemaining()
        if remaining >= 0 {
            return CommonUtils.makeMoneyString(number: remaining) + " Remaining"
        }
        else {
            return CommonUtils.makeMoneyString(number: remaining * -1) + " Over Budget"
        }
    }
    
   
    
    func getIconName() -> String {
        let remaining = self.viewModel.getRemaining()
        if remaining >= 0 {
            return "checkmark.circle.fill"
        }
        else {
            return "exclamationmark.triangle.fill"
        }
    }
    
    
    var body: some View {
        HStack(spacing: 4){
            Image(systemName: getIconName() ).foregroundColor(AppTheme().themeColorPrimary).font(Font.system(size: 14, weight: .semibold))
            
            
            Text(getRemainingDisplayText()).font(.system(size: 16, design: .rounded)).fontWeight(.semibold).foregroundColor(AppTheme().themeColorPrimary)
        }
    }
}

