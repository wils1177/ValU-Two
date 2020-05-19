//
//  BudgetDetailCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetDetailCard: View {
    
    var category : SpendingCategory
    @ObservedObject var service : CategoryEditService
    
    init(category: SpendingCategory, parentService: BalanceParentService){
        self.category = category
        self.service = CategoryEditService(spendingCategory: category, parentService: parentService)
    }
    
    var card: some View{
        VStack{
                   
                   CategoryHeader(name: self.category.name!, icon: self.category.icon!).padding(.horizontal).padding(.top, 10)
                    
                HStack{
                       CustomInputTextField(text: self.$service.editText, placeHolderText: "Amount", textSize: .systemFont(ofSize: 20), alignment: .left, delegate: self.service, key: self.category.name!).id(self.category.id!)
                        
                   }.padding(.horizontal)
                   
                   /*
                   HStack{
                       Text("$" + String(Int(self.category.limit))).font(.system(size: 20)).bold().padding(.leading)
                       Spacer()
                   }.padding(.top, 10).padding(.bottom, 5).padding(.leading, 8)
                   */
            
                   HStack{
                       Text("You've Spent " + "$" + String(Int(self.category.initialThirtyDaysSpent)) + " last month").font(.footnote).foregroundColor(Color(.lightGray))
           
                       Spacer()
                   }.padding(.horizontal).padding(.bottom, 10).padding(.leading, 8)
                   
                   
               }.background(Color(.white)).cornerRadius(15)
    }
    
    
    var body: some View {
        card
    }
}


