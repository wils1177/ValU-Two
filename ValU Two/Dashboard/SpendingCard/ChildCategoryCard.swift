//
//  ChildCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ChildCategoryCard: View {
    
    @ObservedObject var budgetCategory : BudgetCategory
    
    func getPercentage() -> Double{
        if self.budgetCategory.limit != 0.0{
            return self.budgetCategory.getAmountSpent() / self.budgetCategory.limit
        }
        else{
            return 0.0
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                VStack(spacing: 0.0){
                    CategoryHeader(name: self.budgetCategory.spendingCategory!.name!, icon: self.budgetCategory.spendingCategory!.icon!).padding(.horizontal).padding(.top, 10)
                    
                    SpendingSummary(spent: Float(self.budgetCategory.getAmountSpent()), limit: Float(self.budgetCategory.limit))
     
                }
                
                VStack{
                    Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold())
                }.padding(.trailing, 20).padding(.top)

            }
            
            HStack{
                ProgressBarView(percentage: CGFloat(self.getPercentage()), color: colorMap[Int(budgetCategory.budgetSection!.colorCode)], width: 290).padding(.bottom)
            }
            
        }
        .background(Color(.white)).cornerRadius(15)
    }
}


