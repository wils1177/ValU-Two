//
//  SpendingLimitSummaryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/5/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingLimitSummaryView: View {
    
    var viewModel : BudgetBalancerPresentor
    @ObservedObject var budget : Budget
    
    init(viewModel: BudgetBalancerPresentor){

        self.viewModel = viewModel
        self.budget = viewModel.budget
    }
    
    @State var isLarge = true
    
    var body: some View {
        VStack(spacing: 7){
            
            VStack(spacing: 0){
                
                HStack{
                   
                    Text("Summary").font(.system(size: 17, design: .rounded)).fontWeight(.semibold).foregroundColor(AppTheme().themeColorPrimary)
                    Spacer()
            
                }.padding(.bottom, 7)
                
                HStack{
                    Text("\(self.viewModel.getDisplaySpent())\(Text(" / \(self.viewModel.getAvailable())").foregroundColor(Color(.lightGray)).font(.system(size: 22, design: .rounded)))").font(.system(size: 30, design: .rounded)).fontWeight(.bold)
                    Spacer()
                }.padding(.bottom)
                
                
                BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData(), showLegend: true)
                

                
            }
 
        }.padding(.horizontal).padding(.top, 10).background(Color(.systemBackground)).cornerRadius(20)
    }
}




