//
//  DashboardTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct DashboardTabView: View {
    
    var viewModel : DashboardViewModel
    
    init(viewModel: DashboardViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView {
            // 2
            if viewModel.viewData?.homeViewModel != nil{
                HomeView(viewModel: (self.viewModel.viewData?.homeViewModel!)!)
                    // 3
                    .tabItem {
                        VStack {
                            Image(systemName: "1.circle")
                            Text("Home")
                        }
                // 4
                }.tag(1)
            }
            else{
                CouldNotLoadView(errorMessage: "Could Not Load Accounts. Please Try Again.").tabItem {
                        VStack {
                            Image(systemName: "1.circle")
                            Text("Home")
                        }
                // 4
                }.tag(1)
            }
            
            // 5
            TransactionList(viewModel: TransactionsListViewModel())
                .tabItem {
                    VStack {
                        Image(systemName: "2.circle")
                        Text("Transactions")
                    }
            }.tag(2)
            
            CouldNotLoadView(errorMessage: "Budget History")
                .tabItem {
                    VStack {
                        Image(systemName: "3.circle")
                        Text("History")
                    }
            }.tag(3)
            
        }.onAppear {
            self.viewModel.viewAppeared()
        }
    }
}

/*
struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView(presentor: nil)
    }
}
*/
