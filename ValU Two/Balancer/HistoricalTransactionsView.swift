//
//  HistoricalTransactionsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoricalTransactionsView: View {
    
    var viewModel : HistoricalTransactionsViewModel
    var coordinator : BudgetEditableCoordinator?
    
    var body: some View {
        
        List{
            ForEach(viewModel.transactions, id: \.self) { transaction in
                TransactionRow(coordinator: self.coordinator!, transaction: transaction)
            }
        }.listStyle(SidebarListStyle())
        .navigationBarTitle(self.viewModel.budgetCategory.spendingCategory!.name!)
        .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack{
                            Text("*").font(.caption).foregroundColor(AppTheme().themeColorPrimary)
                            Spacer()
                        }
                }
        }

    }
}

