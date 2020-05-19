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
                Text("Overview").font(.headline).bold()
                Spacer()
            }.padding(.horizontal).padding(.top, 10)
            
            HStack(alignment: .bottom, spacing: 2){
                
                Text("$").font(.system(size: 20)).foregroundColor(Color(.black)).bold().padding(.bottom, 5)
                Text(self.viewModel.getLeftToSpend()).font(.system(size: 35)).foregroundColor(.black).bold()
                Text(" / " + self.viewModel.getAvailable()).font(.headline).foregroundColor(Color(.lightGray)).bold().padding(.bottom, 5)
                Spacer()
                
            }.padding(.horizontal).padding(.top, 10)
            
            HStack{
                Text("Left To Budget").font(.subheadline).foregroundColor(Color(.lightGray)).bold()
                Spacer()
            }.padding(.horizontal).padding(.horizontal).padding(.bottom, 10)
            
            ProgressBarView(percentage: CGFloat(self.viewModel.getPercentage()), color: Color(.green)).padding(.bottom)
            
            
            
            
        }.background(Color(.white))
    }
}




