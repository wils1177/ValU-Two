//
//  MyMoneyTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct MyMoneyTabView: View {
    
    var viewModel : MyMoneyViewModel
    var coordinator : MoneyTabCoordinator?
    
    var body: some View {
        
        VStack{
            
            
            List{
                
                
                
                BalanceSummaryView().padding(.horizontal, 5).padding(.top, 25).padding(.bottom)
                
                //CashFlowHighlightView().padding(.horizontal, 5).padding(.top, 5)
                
                SwiftUIAccountsView(coordinator: self.coordinator).padding(.top, 10)
                
            }
 
        }
        
        .navigationBarTitle("Accounts")
    }
}


