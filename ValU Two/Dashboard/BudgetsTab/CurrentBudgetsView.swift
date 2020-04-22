//
//  CurrentBudgetsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/8/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CurrentBudgetsView: View {
    
    var budgets: [Budget]
    var viewModel: BudgetsViewModel
    
    var body: some View {
        
            ForEach(self.budgets, id: \.self) { budget in
                CurrentBudgetEntry(budget: budget)
        }.id(UUID())
        
        
    }
}


