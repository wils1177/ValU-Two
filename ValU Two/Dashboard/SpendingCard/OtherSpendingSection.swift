//
//  OtherSpendingSection.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct OtherSpendingSection: View {
    
    var viewModel : SpendingCardViewModel
    
    var barHeight = 50
    var iconText : String
    var categoryName : String
    //var amountSpent = "$550"
    var percentage : CGFloat
    var hue : Double = 0.35
    
    init(viewModel : SpendingCardViewModel){
        self.viewModel = viewModel
        self.iconText = viewModel.otherCategory!.icon
        self.categoryName = viewModel.otherCategory!.name
        
        
        
        if viewModel.otherCategory!.percentage < 0.1{
            self.percentage = 0.1
        }
        else{
            self.percentage = viewModel.otherCategory!.percentage
        }
    }
    

    
    
    var body: some View {
        
        VStack(spacing: 0){
              HStack{
                  VStack(spacing: 0.0){
                    CategoryHeader(name: "Everything Else", icon: "🗺️").padding(.horizontal).padding(.top, 10)
                      
                    SpendingSummary(spent: self.viewModel.otherCategory!.spent, limit: self.viewModel.otherCategory!.limit)
        
                  }
                  VStack{
                      Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold())
                  }.padding(.trailing, 20).padding(.top)
              }
              
              HStack{
                  ProgressBarView(percentage: self.viewModel.otherCategory!.percentage, color: Color(.purple), width: 290).padding(.bottom)
              }
              
          }
          .background(Color(.white)).cornerRadius(15)
        
    }
}

