//
//  ParentCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ParentCategoryCard: View {
    
    @ObservedObject var budgetSection : BudgetSection
    @ObservedObject var service : BalanceParentService
    
    init(budgetSection: BudgetSection, service: BalanceParentService){
        self.budgetSection = budgetSection
        self.service = service
        
        
    }
    
    
    var body: some View {
        
        HStack{
            VStack(spacing: 2){
                CategoryHeader(name: self.budgetSection.name!, icon: self.budgetSection.icon!).padding(.horizontal).padding(.top, 10)
                
                HStack(spacing: 0){
                    BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)]).padding(.leading).padding(.bottom)
                    
                    VStack(alignment: .leading, spacing:0){
                        
                        
                        SpendingSummary(spent: Float(service.getParentSpent()), limit: Float(service.getParentLimit()))
                        
                        ProgressBarView(percentage: CGFloat(self.service.getPercentageSpent()), color: colorMap[Int(self.budgetSection.colorCode)], width: 250).padding(.bottom)
                    }.padding(.leading)
                    
                    Spacer()
                    
                }
            }
            
            Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold()).padding(.trailing)
            
        }
        
        .background(Color(.white)).cornerRadius(15)
        
        /*
        VStack(spacing: 0){
            HStack{
                VStack(spacing: 0.0){
                    
                    
                    
      
                }
                VStack{
                    Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold())
                }.padding(.trailing, 20).padding(.top)
            }
            
            HStack{
                
            }
            
        }
        
        */
    }
}


