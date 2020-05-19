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
                
                HStack{
                    Text("Summary").font(.system(size: 22)).bold()
                    Spacer()
                    
                }.padding(.top, 10)
                
                BalanceSummaryView().padding(.horizontal, 5).padding(.top, 5)
                
                //CashFlowHighlightView().padding(.horizontal, 5).padding(.top, 5)
                
                SwiftUIAccountsView(coordinator: self.coordinator).padding(.top, 10)
                
            }
 
        }
        
        .navigationBarTitle("My Money")
    }
}


