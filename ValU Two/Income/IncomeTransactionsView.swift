//
//  IncomeTransactionsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeTransactionsView: View {
    
    var transactions : [Transaction]
    var coordinator : BudgetEditableCoordinator?
    
    var transactionsService = TransactionService()
    
    init(transactions : [Transaction]){
        self.transactions = transactions
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(self.transactions, id: \.self){ transaction in
                    TransactionRow(coordinator: nil, transaction: transaction, transactionService: self.transactionsService).padding(.bottom, 5).padding(.horizontal)
                }.padding(.top)
            }.padding(.top)
            .navigationTitle("Past Income").navigationBarItems( trailing:
            
                            Button(action: {
                                self.coordinator?.dismiss()
                                                      }) {
                                ColoredActionButton(text: "Done")
                                             }
            
            )
        }
        
    }
}


