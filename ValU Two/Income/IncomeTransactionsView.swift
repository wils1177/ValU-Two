//
//  IncomeTransactionsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeTransactionsView: View {
    
    @ObservedObject var incomeService : BudgetIncomeService
    
    init(incomeService : BudgetIncomeService){
        self.incomeService = incomeService
    }
    
    var body: some View {
        VStack{
            ForEach(self.incomeService.getIncomeTransactions(), id: \.self){ transaction in
                TransactionRow(coordinator: nil, transaction: transaction).padding(.bottom)
            }
        }
    }
}


