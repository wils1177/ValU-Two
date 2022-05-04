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
    
    
    
    
  
    
    var body: some View {
        ScrollView{
            
            Text("Other")
            
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle("Other")
        
    }
}


