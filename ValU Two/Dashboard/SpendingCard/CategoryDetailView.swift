//
//  CategoryDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryDetailView: View {
    
    var budgetSection : BudgetSection
    var coordinator : BudgetsTabCoordinator
    
    var body: some View {
        List{
            VStack(spacing: 0.0){
                ForEach(self.budgetSection.budgetCategories?.allObjects as! [BudgetCategory], id: \.self) { category in
                    VStack(spacing: 0.0){
                        if category.limit > 0.0{
                            
                            Button(action: {
                                // your action here
                                self.coordinator.showCategory(category: category.spendingCategory!)
                            }) {
                                ChildCategoryCard(budgetCategory: category).padding(.bottom, 15)
                            }.buttonStyle((PlainButtonStyle()))
                            
                            
                        }
                    }
                    
                    
                }
            }
            
        }
    }
}


