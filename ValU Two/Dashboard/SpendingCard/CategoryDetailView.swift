//
//  CategoryDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryDetailView: View {
    
    var sectionModel : BudgetDetailViewModel
    var coordinator : BudgetsTabCoordinator
    
    var transactionsZeroState : some View{
        VStack{
            Text("No transaction for this category yet").font(.subheadline)
        }.padding().background(Color(.white)).cornerRadius(15)
    }
    
    
    var transactionsSection : some View {
        VStack{
            ForEach(self.sectionModel.categories, id: \.self) { category in
                Section(header: ChildCategoryCard(budgetCategory: category.category)){
                    
                    
                    if category.transactions.count > 0{
                        
                        ForEach(category.transactions, id: \.self) { transaction in
                            TransactionRow(coordinator: self.coordinator, transaction: transaction).padding(.bottom, 10)
                        }.listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                    }
                    else{
                        
                        HStack{
                            Spacer()
                            self.transactionsZeroState.padding(.bottom)
                            Spacer()
                        }
                        
                        
                    }
                    
                    
                }.padding(.top)
        }
        
    }
    }


    var body: some View {
        List{
            
            ParentCategoryCard(budgetSection: self.sectionModel.section).padding(.top)
            
            
            transactionsSection

  
            }.listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0)).listStyle(SidebarListStyle())
            

        }
}



