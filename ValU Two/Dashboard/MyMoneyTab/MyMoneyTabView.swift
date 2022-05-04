//
//  MyMoneyTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct MyMoneyTabView: View {
    
    @ObservedObject var viewModel : MyMoneyViewModel
    var coordinator : MoneyTabCoordinator?
    
    var body: some View {
         
            List{
                
                
                
                BalanceSummaryView().padding(.horizontal, 5).padding(.top, 25).listRowBackground(Color.clear).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowSeparator(.hidden).padding(.bottom)
                
                //CashFlowHighlightView().padding(.horizontal, 5).padding(.top, 5)
                
                SwiftUIAccountsView(coordinator: self.coordinator).listRowBackground(Color.clear).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowSeparator(.hidden).padding(.horizontal, 10).padding(.top, 20)
                
            }.listStyle(PlainListStyle())
            .refreshable {
                let refreshModel = OnDemandRefreshViewModel()
                await refreshModel.refreshAllItems()
            }
        
            .background(Color(.systemGroupedBackground))
        .navigationBarTitle("Accounts")
    }
}


