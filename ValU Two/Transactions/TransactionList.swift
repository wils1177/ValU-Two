//
//  TransactionList.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
    
    @ObservedObject var viewModel : TransactionsListViewModel
    
    var showSummary = false
    
    var transactionsService = TransactionService()
    
    init(viewModel: TransactionsListViewModel, showSummary: Bool = false) {
        
        self.viewModel = viewModel
        self.showSummary = showSummary
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        
    }
    
    
    var body: some View {
        
        ScrollView{
            VStack{
                
                if self.viewModel.transactions.count > 0{

                    
                    ForEach(self.viewModel.transactions, id: \.self) { transaction in
                        
                        VStack{
                            
                                
                            VStack{
                                TransactionRow(coordinator: self.viewModel.coordinator!, transaction: transaction, transactionService: TransactionService()).padding(.horizontal).padding(.bottom, 5)
                            }
                             
                        }
                        
                        
                        
                        
                    }.listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                }
                else{
                    EmptyState(errorMessage: "There are no transactions here yet")
                }
                
                
                
                
            }.padding(.top)
        }
            
        
        
        
        
    }
}

/*
struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList()
    }
}
*/
