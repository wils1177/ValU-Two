//
//  BudgetBalanceCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/10/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetBalanceCard: View {
    
    @ObservedObject var spendingCategory : SpendingCategory
    @ObservedObject var service : BalanceParentService
    var coordinator : SetSpendingLimitDelegate
    
    init(service: BalanceParentService, spendingCategory: SpendingCategory, coordinator: SetSpendingLimitDelegate){
        self.spendingCategory = spendingCategory
        self.service = BalanceParentService(spendingCategory: spendingCategory)
        self.coordinator = coordinator
    }
    
    var card : some View{
        HStack{
            VStack{
                       
                CategoryHeader(name: self.spendingCategory.name!, icon: self.spendingCategory.icon!).padding(.horizontal).padding(.top, 10)


                       
                       HStack{
                        Text("$" + String(Int(self.service.getParentLimit()))).font(.system(size: 25)).bold().padding(.leading)
                           Spacer()
                       }.padding(.top, 10).padding(.bottom, 5).padding(.leading, 8)
                       
                       HStack{
                           Text("You've Spent " + "$" + String(Int(self.spendingCategory.initialThirtyDaysSpent)) + " last month").font(.footnote).foregroundColor(Color(.lightGray))
               
                           Spacer()
                       }.padding(.horizontal).padding(.bottom, 10).padding(.leading, 8)
                       
                       
                   }
            
            Spacer()
            VStack{
                Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold())
            }.padding(.trailing, 20)
            
        }
        
        .background(Color(.white)).cornerRadius(15)
    }
    
    
    var body: some View {
        
        Button(action: {
            self.coordinator.showCategoryDetail(category: self.spendingCategory, service: self.service)
        }) {
            self.card
        }.buttonStyle(PlainButtonStyle())
    }
}
