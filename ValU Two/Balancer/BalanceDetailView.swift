//
//  BalanceDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BalanceDetailView: View {
    
    var spendingCategory : SpendingCategory
    @ObservedObject var service : BalanceParentService
    
    init(category : SpendingCategory, service : BalanceParentService){
        self.spendingCategory = category
        self.service = service
    }
    
    
    var topCard: some View{
        VStack(alignment: .center){
                   
                   //CategoryHeader(name: self.spendingCategory.name!, icon: self.spendingCategory.icon!).padding(.horizontal).padding(.top, 10)

            HStack(){
                Spacer()
                VStack{
                    Text("").font(.system(size: 22)).bold()
                    //Text(self.spendingCategory.name!).font(.system(size: 17)).foregroundColor(Color(.black)).bold()
                }
                
                Spacer()

            }.padding(.top)

            
            HStack{
                Spacer()
                Text("$" + String(Int(self.service.getParentLimit()))).font(.system(size: 42)).bold()
                Spacer()
            }
            HStack{
                Spacer()
                Text("Budgeted").font(.headline).foregroundColor(Color(.lightGray))
                Spacer()
            }.padding(.bottom).padding(.bottom)
            
            
                   
            /*
                   HStack{
                    Text("$" + String(Int(self.service.getParentLimit()))).font(.system(size: 35)).bold().padding(.leading)
                       Spacer()
                   }.padding(.top, 10).padding(.bottom, 5).padding(.leading, 8)
                   
                   HStack{
                       Text("You've Spent " + "$" + String(Int(self.spendingCategory.initialThirtyDaysSpent)) + " last month").font(.footnote).foregroundColor(Color(.lightGray))
           
                       Spacer()
                   }.padding(.horizontal).padding(.bottom, 10).padding(.leading, 8)
               */
                   
               }//.background(Color(.white)).cornerRadius(15)
    }
    
    
    
    var body: some View {
        List{
                
                topCard
                
            VStack{
                HStack{
                    Text(self.spendingCategory.icon! + " " + self.spendingCategory.name! + " Budget").font(.system(size: 22)).bold()
                        Spacer()
                    }.padding(.top)
                
                    HStack{
                        Text("Budget for the categorie you'd like to include").font(.subheadline).foregroundColor(Color(.lightGray))
                        Spacer()
                    }.padding(.bottom, 5).padding(.top, 5)
            }.padding(.horizontal, 10)
                
            
            ForEach(self.spendingCategory.subSpendingCategories?.allObjects as! [SpendingCategory], id: \.self) { child in
                VStack{
                    BudgetDetailCard(category: child, parentService: self.service)
                }
            }
                
                
        }.navigationBarTitle(self.spendingCategory.name!)
    }
}



