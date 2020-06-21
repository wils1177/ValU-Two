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
    
    init(viewModel: TransactionsTabViewModel){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

               // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
    }
    
    var body: some View {
            
            
            List(self.viewModel.rows!, id: \.self) { row in
                
                if row.spendingSummary != nil{
                    SpendingSummaryView().animation(.easeInOut(duration: 0.6))
                }
                else if row.sectionTitle != nil{
                    HStack{
                        Text(row.sectionTitle!).font(.system(size: 22)).fontWeight(.bold)
                        Spacer()
                    }.padding(.horizontal)
                    
                }
                else{
                        TransactionRow(coordinator: self.viewModel.coordinator!, transaction : row.transactionRow!)
                    
                    
                }
                
                
                
                }
            .navigationBarTitle(Text("Transactions"))
            
        
    }
}


