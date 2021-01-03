//
//  TransactionsTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionsTabView: View {
    
    @ObservedObject var viewModel : TransactionsTabViewModel
    @ObservedObject var filterModel : TransactionFilterModel
    
    init(viewModel: TransactionsTabViewModel, filterModel : TransactionFilterModel){
        self.viewModel = viewModel
        self.filterModel = filterModel
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

               // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
    }
    
    var body: some View {
            
        List{
            
                TransactionsFilterView(filterModel: self.viewModel.filterModel, coordinator: self.viewModel.coordinator!).padding(.bottom, 10)
            
            
                ForEach(self.viewModel.getTransactionsList(), id: \.self) { transaction in
                    
                    TransactionRow(coordinator: self.viewModel.coordinator!, transaction : transaction) .listRowInsets(EdgeInsets()).padding(.bottom, 10)
                    
                }
            
            

        }.listStyle(SidebarListStyle())
            .navigationBarTitle(Text("Transactions"))
            
        
    }
}


