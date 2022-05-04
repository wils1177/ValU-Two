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
                   
                    Text("Left to Budget").font(.system(size: 17, design: .rounded)).fontWeight(.bold).foregroundColor(Color(.gray))
                    Spacer()
            
                }.padding(.bottom, 5)
                
                HStack{
                    Text("\(self.viewModel.getDisplayAmountRemaining())\(Text(" / \(self.viewModel.getAvailable())").foregroundColor(Color(.lightGray)).font(.system(size: 24, design: .rounded)))").font(.system(size: 38, design: .rounded)).fontWeight(.bold)
                    Spacer()
                }.padding(.bottom, 10)
                
                
                BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData(), showLegend: false)
                

                
            }
 
        }
    }
}




