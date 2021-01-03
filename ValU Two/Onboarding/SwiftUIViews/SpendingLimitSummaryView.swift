//
//  SpendingLimitSummaryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/5/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingLimitSummaryView: View {
    
    @ObservedObject var viewModel : BudgetBalancerPresentor
    @ObservedObject var budget : Budget
    
    init(viewModel: BudgetBalancerPresentor){

        self.viewModel = viewModel
        self.budget = viewModel.budget
    }
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text("Summary").font(.headline).bold()
                Spacer()
            }.padding(.leading).padding(.top).padding(.bottom, 5)
            
            HStack(alignment: .bottom, spacing: 2){
                
                Text(self.viewModel.getDisplaySpent()).font(.system(size: 35)).foregroundColor(.black).bold()
                Text(" of " + self.viewModel.getAvailable()).font(.headline).foregroundColor(Color(.lightGray)).bold().padding(.bottom, 5)
                Spacer()
                
            }.padding(.leading).padding(.bottom, 5)
            
           
            
            BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData())
            
            
            
            
        }.background(Color(.white)).cornerRadius(15)
    }
}




