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
                Text("SPENT IN BUDGETS").font(.system(size: 16)).foregroundColor(Color(.gray)).fontWeight(.light).padding(.bottom)
                Spacer()
            }
            
            
            HStack(alignment: .bottom, spacing: 2){
                
                Text("$").font(.system(size: 35)).foregroundColor(Color(.black)).bold()
                Text(self.viewModel.getDisplaySpent()).font(.system(size: 35)).foregroundColor(.black).bold()
                Text(" / " + self.viewModel.getAvailable()).font(.headline).foregroundColor(Color(.lightGray)).bold().padding(.bottom, 5)
                Spacer()
                
            }.padding(.bottom).padding(.leading)
            
           
            
            BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData())
            
            
            
            
            }.padding().background(Color(.white))
    }
}




