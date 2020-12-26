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
    
    init(coordinator: MoneyTabCoordinator?, account : AccountData){
        self.account = account
        self.coordinator = coordinator
        let service = AccountDetailService(account: account)
        self.transactions = service.getTransactionsForAccount()
        
    }
    
    var body: some View {
        
        List{
                SwiftUIAccountCardView(account: self.account)
                ForEach(self.transactions, id: \.self){ transaction in
                    
                    TransactionRow(coordinator: self.coordinator, transaction: transaction)
                    
                
            }.listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))

        }.listStyle(SidebarListStyle()).navigationBarTitle(self.account.name!)
        
        
    }
}

