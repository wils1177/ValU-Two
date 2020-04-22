//
//  MyMoneyTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct MyMoneyTabView: View {
    
    var viewModel : MyMoneyViewModel
    
    var body: some View {
        List{
            BalanceSummaryView().padding(.top)
            SwiftUIAccountsView().padding(.top)
            IncomeCardView(viewModel: self.viewModel.cashFlowViewModel).padding(.top)
        }.navigationBarTitle("My Money")
    }
}


