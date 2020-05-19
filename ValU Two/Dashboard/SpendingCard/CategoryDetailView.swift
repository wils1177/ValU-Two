//
//  CategoryDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryDetailView: View {
    
    var spendingCategory : SpendingCategory
    var coordinator : BudgetsTabCoordinator
    
    var body: some View {
        List{
            VStack(spacing: 0.0){
                ForEach(self.spendingCategory.subSpendingCategories?.allObjects as! [SpendingCategory], id: \.self) { category in
                    VStack(spacing: 0.0){
                        if category.limit > 0.0{
                            
                            Button(action: {
                                // your action here
                                self.coordinator.showCategory(categoryName: category.name!)
                            }) {
                                ChildCategoryCard(spendingCategory: category).padding(.bottom, 15)
                            }.buttonStyle((PlainButtonStyle()))
                            
                            
                        }
                    }
                    
                    
                }
            }
            
        }
    }
}


