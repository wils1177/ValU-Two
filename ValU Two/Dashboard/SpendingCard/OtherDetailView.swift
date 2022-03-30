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
    
    
    
    
    
    var unassignedTransactionsSection : some View {
        Section(){
            ForEach(viewModel.unassignedTransactions, id: \.self) { transaction in
                TransactionRow(coordinator: self.coordinator, transaction: transaction, transactionService: self.transactionsService).padding(.top,5)
            }
        }.listRowInsets(EdgeInsets())
        
    }
    
    var body: some View {
        ScrollView{
            LazyVStack{
                DetailedParentCategoryCard(color: AppTheme().otherColor, colorSecondary: AppTheme().otherColorSecondary, colorTertiary: AppTheme().otherColorTertiary, icon: "book", spent: self.otherCardData.spent, limit: self.otherCardData.limit, name: "Other", percentageSpent: Double(self.otherCardData.percentage)).padding(.horizontal).padding(.vertical).shadow(radius: 5)
                if self.viewModel.unassignedTransactions.count > 0{
                    unassignedTransactionsSection.padding(.horizontal)
                }
            }
            
            
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle("Other")
        
    }
}


