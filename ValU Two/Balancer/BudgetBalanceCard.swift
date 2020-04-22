//
//  BudgetBalanceCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/10/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetBalanceCard: View {
    
    var viewModel : BudgetBalancerPresentor
    @ObservedObject var viewData : BalanceCategoryViewData
    
    
    
    init(viewModel: BudgetBalancerPresentor, viewData: BalanceCategoryViewData){
        self.viewModel = viewModel
        self.viewData = viewData
    }
    
    
    var body: some View {
        VStack{
            
            HStack(){
                Text(self.viewData.icon).font(.subheadline)
                Text(self.viewData.name).font(.subheadline).foregroundColor(Color(.black))
                Spacer()
                Button(action: {
                    self.viewModel.deleteCategory(name: self.viewData.name)
                }){
                    
                    Image(systemName: "x.circle.fill").foregroundColor(Color(.gray))

                }.buttonStyle(PlainButtonStyle())
                
                
            }.padding(.horizontal).padding(.top)
             
            HStack{
                CustomInputTextField(text: self.$viewData.limit, placeHolderText: "Amount", textSize: .systemFont(ofSize: 20), alignment: .left, delegate: self.viewModel, key: self.viewData.name).id(self.viewData.index)
                //TextField("test", text: self.$viewData.limit)
                
                
                Stepper("", onIncrement: {
                    print("up")
                    self.viewModel.incrementCategory(categoryName: self.viewData.name, incrementAmount: 10)
                }, onDecrement: {
                    print("down")
                    self.viewModel.incrementCategory(categoryName: self.viewData.name, incrementAmount: -10)
                }).id(self.viewData.index)
                
 
            }.padding(.horizontal)
            
            HStack{
                Text("You've Spent " + self.viewData.lastThirtyDaysSpent + " last month").font(.callout).foregroundColor(Color(.lightGray))
                Spacer()
            }.padding(.horizontal).padding(.bottom)
            
            
            }.background(Color(.white)).cornerRadius(15).shadow(radius: 5)
    }
}
