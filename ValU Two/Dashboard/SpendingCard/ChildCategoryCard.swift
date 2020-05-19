//
//  ChildCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ChildCategoryCard: View {
    
    @ObservedObject var spendingCategory : SpendingCategory
    
    func getPercentage() -> Float{
        if self.spendingCategory.limit != 0.0{
            return self.spendingCategory.getAmountSpent() / self.spendingCategory.limit
        }
        else{
            return 0.0
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                VStack(spacing: 0.0){
                    CategoryHeader(name: self.spendingCategory.name!, icon: self.spendingCategory.icon!).padding(.horizontal).padding(.top, 10)
                    
                    SpendingSummary(spent: self.spendingCategory.getAmountSpent(), limit: self.spendingCategory.limit)
     
                }
                
                VStack{
                    Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold())
                }.padding(.trailing, 20).padding(.top)

            }
            
            HStack{
                ProgressBarView(percentage: CGFloat(self.getPercentage()), color: Color(.purple), width: 290).padding(.bottom)
            }
            
        }
        .background(Color(.white)).cornerRadius(15)
    }
}


