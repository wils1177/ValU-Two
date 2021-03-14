//
//  CategoryDetailTransactionsSection.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/19/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryDetailTransactionsSection: View {
    
    @State var transactionsHidden : Bool = true
    
    var category : BudgetDetailCatgeryViewData
    var coordinator : BudgetsTabCoordinator
    
    var transactionService = TransactionService()
    
    init(category: BudgetDetailCatgeryViewData, coordinator: BudgetsTabCoordinator){
        self.category = category
        self.coordinator = coordinator
        
        if category.transactions.count == 0{
            self.transactionsHidden = true
        }
    }
    
    var transactionsZeroState : some View{
        VStack{
            Text("No transaction for this category yet.").font(.subheadline)
        }.padding(.horizontal).padding(.vertical, 5).background(Color(.clear)).cornerRadius(15)
    }
    
    var body: some View {
        
        VStack(spacing:5){
            
            Button(action: {
                // What to perform
                //withAnimation {
                //    self.transactionsHidden.toggle()
                //}
                
                self.coordinator.showCategory(category: self.category.category.spendingCategory!)
                
            }) {
                // How the button looks like
                    
                ChildCategoryCard(limit: category.category.limit, spent: category.category.getAmountSpent(), icon: category.category.spendingCategory!.icon!, name: category.category.spendingCategory!.name!).padding(.horizontal)
                    
                   

                    
                
                
            }.buttonStyle(PlainButtonStyle()).foregroundColor(colorMap[Int((category.category.budgetSection!.colorCode))])
            
            
            
                
            //Divider().padding(.leading, 20).padding(.bottom, 5).padding(.top, 10)
            
            if !self.transactionsHidden{
                if category.transactions.count > 0{
                    
                    ForEach(category.transactions, id: \.self) { transaction in
                        TransactionRow(coordinator: self.coordinator, transaction: transaction, transactionService: self.transactionService).padding(.horizontal, 15)
                    }.transition(.scale).padding(.top, 10)
                }
                else{
                    
                    HStack{
                        Spacer()
                        self.transactionsZeroState.padding(.bottom).padding(.horizontal, 5)
                        Spacer()
                    }.transition(.scale).padding(.top, 10)
                    
                    
                }
            }
        }

            
            
        }
}

