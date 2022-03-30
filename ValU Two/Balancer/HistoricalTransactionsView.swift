//
//  HistoricalTransactionsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoricalTransactionsView: View {
    
    @ObservedObject var viewModel : HistoricalTransactionsViewModel
    var coordinator : BudgetEditableCoordinator?
    var budgetCategory: BudgetCategory
    
    
    var transactionsService = TransactionService()
    
    @State private var searchText = ""
    
    @State private var transactionType = 0
    
    init(viewModel: HistoricalTransactionsViewModel, budgetCategory: BudgetCategory){
        self.viewModel = viewModel
        self.budgetCategory = budgetCategory
    }
    
    var searchResults: [Transaction] {
            if searchText.isEmpty {
                return self.viewModel.transactions
            } else {
                return self.viewModel.transactions.filter { $0.name!.contains(searchText) }
            }
        }
    
    
    
    var noTransactionsForCategoryView : some View{
        
        VStack(alignment: .center){
            
            Text("No Transactions for Category").font(.title).bold().multilineTextAlignment(.center).padding(.vertical, 30)
            
            Text("If you think you do have transactions for this category, you can select All Transactions to begin tagging transactions to this category").font(.body).multilineTextAlignment(.center).padding(.horizontal)
        }
        
    }
    
    
    
    var body: some View {
        
        
        
        List{
            
            
            Section{
                if self.transactionType == 0 {
                    if self.viewModel.getTransactionsForCategory(budgetCategory: budgetCategory).count > 0{
                        
                            ForEach(searchResults, id: \.self) { transaction in
                                if viewModel.isTransactionInCategory(transaction: transaction, budgetCategory: self.budgetCategory){
                                    TransactionRow(coordinator: self.coordinator!, transaction: transaction, transactionService: self.transactionsService)
                                }
                                
                            }
                        
                    }
                    else{
                        self.noTransactionsForCategoryView//.listRowSeparator(.hidden)
                    }
                    
                }
                else{
                    
                        ForEach(searchResults, id: \.self) { transaction in
                            HStack{
                                TransactionRow(coordinator: self.coordinator!, transaction: transaction, transactionService: self.transactionsService)
                                
                                Button(action: {
                                    self.viewModel.addTransactionToCategory(transaction: transaction, budgetCategory: self.budgetCategory)
                                    
                                }) {
                                    Image(systemName: "plus.circle.fill").font(.system(size: 25)).foregroundColor(AppTheme().themeColorPrimary)
                                }.buttonStyle(PlainButtonStyle())
                                
                            }
                            
                        }
                    
                }
            }
            
            
            
        }
        .background(Color(.systemGroupedBackground))
        .searchable(text: $searchText)
        .navigationBarTitle(self.budgetCategory.spendingCategory!.name!)
        .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Picker(selection: $transactionType, label: Text("Transactions")) {
                            Text(self.budgetCategory.spendingCategory!.name!).tag(0)
                                Text("All Transactions").tag(1)
                            
                            
                        }.pickerStyle(SegmentedPickerStyle()).listRowSeparator(.hidden)
                }
        }

    }
}

