//
//  ParentCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ParentCategoryCard: View {
    
    @ObservedObject var spendingCategory : SpendingCategory
    @ObservedObject var service : BalanceParentService
    
    init(spendingCategory: SpendingCategory, service: BalanceParentService){
        self.spendingCategory = spendingCategory
        self.service = service
    }
    
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                VStack(spacing: 0.0){
                    CategoryHeader(name: self.spendingCategory.name!, icon: self.spendingCategory.icon!).padding(.horizontal).padding(.top, 10)
                    
                    SpendingSummary(spent: service.getParentSpent(), limit: service.getParentLimit())
      
                }
                VStack{
                    Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold())
                }.padding(.trailing, 20).padding(.top)
            }
            
            HStack{
                ProgressBarView(percentage: CGFloat(self.service.getPercentageSpent()), color: Color(.purple), width: 290).padding(.bottom)
            }
            
        }
        .background(Color(.white)).cornerRadius(15)
        
    }
}


