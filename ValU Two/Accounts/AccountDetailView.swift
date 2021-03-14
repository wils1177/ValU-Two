//
//  AccountDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct AccountDetailView: View {
    
    var account : AccountData
    var transactions = [Transaction]()
    var coordinator : MoneyTabCoordinator?
    
    var transactionsService = TransactionService()
    
    init(coordinator: MoneyTabCoordinator?, account : AccountData){
        self.account = account
        self.coordinator = coordinator
        let service = AccountDetailService(account: account)
        self.transactions = service.getTransactionsForAccount()
        
    }
    
    var zeroState: some View {
        VStack(alignment: .center){
            Text("No Transactions").font(.title2).bold()
        }
    }
    
    var body: some View {
        
        ScrollView{
            LazyVStack{
                SwiftUIAccountCardView(account: self.account).padding(.horizontal).padding(.vertical).shadow(radius: 15)
                
                if self.transactions.count > 0 {
                    ForEach(self.transactions, id: \.self){ transaction in
                        
                        TransactionRow(coordinator: self.coordinator, transaction: transaction, transactionService: self.transactionsService).padding(.horizontal)
                    }
                }
                else{
                    zeroState.padding(.top, 50)
                }
                
                
                     
            }

        }.navigationBarTitle(self.account.name!)
        
        
    }
}

