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
    
    var transactionsService = TransactionService()
    
    var body: some View {
        
        ScrollView{
            VStack{
                ForEach(viewModel.transactions, id: \.self) { transaction in
                    TransactionRow(coordinator: self.coordinator!, transaction: transaction, transactionService: self.transactionsService).padding(.horizontal).padding(.bottom, 5)
                }
            }
            
        }
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

