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
    
    var body: some View {
        VStack(spacing: 0){
            
            /*
            HStack{
                Text("Summary").font(.system(size: 21, design: .rounded)).bold()
                Spacer()
            }.padding(.leading).padding(.bottom, 5)
            */
            
            HStack(alignment: .bottom, spacing: 2){
                
                Text(self.viewModel.getDisplaySpent()).font(.system(size: 35, design: .rounded)).bold()
                Text(" of " + self.viewModel.getAvailable()).font(.system(size: 20, design: .rounded)).bold().foregroundColor(Color(.lightGray)).bold().padding(.bottom, 5)
                Spacer()
                
            }.padding(.leading).padding(.bottom, 8)
            
           
            
            BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData())
            
            
            
            
        }//.padding(.vertical, 5).padding(.top, 10).background(Color(.systemBackground)).cornerRadius(15).shadow(radius: 5)
    }
}




