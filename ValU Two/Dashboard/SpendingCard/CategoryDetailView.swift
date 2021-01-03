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
            Text("No transaction for this category yet.").font(.subheadline)
        }.padding(.horizontal).padding(.vertical, 5).background(Color(.clear)).cornerRadius(15)
    }
    
    
    var transactionsSection : some View {
            ForEach(self.sectionModel.categories, id: \.self) { category in
                Section(header: ChildCategoryCard(budgetCategory: category.category)){
                    
                    
                    if category.transactions.count > 0{
                        
                        ForEach(category.transactions, id: \.self) { transaction in
                            TransactionRow(coordinator: self.coordinator, transaction: transaction).padding(.bottom, 10)
                        }
                    }
                    else{
                        
                        HStack{
                            Spacer()
                            self.transactionsZeroState.padding(.bottom)
                            Spacer()
                        }
                        
                        
                    }
                    
                    
                }.listRowInsets(EdgeInsets())
        }
        
    
    }


    var body: some View {
        List{
            
            DetailedParentCategoryCard(budgetSection: self.sectionModel.section).padding(.top)
            
            
            transactionsSection.listRowInsets(EdgeInsets())

  
            }.listStyle(SidebarListStyle())
            

        }
}



