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
    var coordinator : MoneyTabCoordinator?
    
    var body: some View {
         
            ScrollView{
                
                
                
                BalanceSummaryView().padding(.horizontal, 5).padding(.top, 25).padding(.bottom)
                
                //CashFlowHighlightView().padding(.horizontal, 5).padding(.top, 5)
                
                SwiftUIAccountsView(coordinator: self.coordinator).padding(.horizontal, 10)
                
            }.background(Color(.systemGroupedBackground))
 
        
        
        .navigationBarTitle("Accounts")
    }
}


