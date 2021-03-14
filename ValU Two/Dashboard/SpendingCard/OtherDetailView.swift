//
//  OtherDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/16/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct OtherDetailView: View {
    
    var viewModel : OtherBudgetViewModel
    var coordinator : BudgetsTabCoordinator
    var otherCardData: SpendingCategoryViewData
    
    var transactionsService = TransactionService()
    
    var transactionsZeroState : some View{
        VStack{
            Text("No transaction for this category yet.").font(.subheadline)
        }.padding(.horizontal).padding(.vertical, 5).background(Color(.clear)).cornerRadius(15)
    }
    
    var transactionsSection : some View {
            ForEach(self.viewModel.categoriesData, id: \.self) { category in
                Section(header: ChildCategoryCard(limit: 0.0, spent: 0.0, icon: category.spendingCategory.icon!, name: category.spendingCategory.name!)){
                    
                    Divider().padding(.leading, 20).padding(.bottom, 10)
                    
                    if category.transactions.count > 0{
                        
                        ForEach(category.transactions, id: \.self) { transaction in
                            TransactionRow(coordinator: self.coordinator, transaction: transaction, transactionService: self.transactionsService).padding(.bottom, 10)
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
    
    var unassignedSectionHeader : some View {
        HStack{
            Text("Unassigned Transactions").font(.system(size: 20)).foregroundColor(Color(.black)).bold()
            Spacer()
        }.padding(.leading)
    }
    
    var unassignedTransactionsSection : some View {
        Section(header: unassignedSectionHeader){
            ForEach(viewModel.unassignedTransactions, id: \.self) { transaction in
                TransactionRow(coordinator: self.coordinator, transaction: transaction, transactionService: self.transactionsService).padding(.bottom, 10)
            }
        }.listRowInsets(EdgeInsets())
        
    }
    
    var body: some View {
        ScrollView{
            LazyVStack{
                DetailedParentCategoryCard(color: AppTheme().otherColor, colorSecondary: AppTheme().otherColorSecondary, colorTertiary: AppTheme().otherColorTertiary, icon: "book", spent: self.otherCardData.spent, limit: self.otherCardData.limit, name: "Other", percentageSpent: Double(self.otherCardData.percentage)).padding(.horizontal)
                transactionsSection.padding(.horizontal)
                if self.viewModel.unassignedTransactions.count > 0{
                    unassignedTransactionsSection.padding(.horizontal)
                }
            }
            
            
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle("Other")
        
    }
}


