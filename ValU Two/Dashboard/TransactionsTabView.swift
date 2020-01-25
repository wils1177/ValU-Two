//
//  TransactionsTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionsTabView: View {
    var body: some View {
        NavigationView{
            VStack{
                TransactionList(viewModel: TransactionsListViewModel())
            }.navigationBarTitle("Transactions")
            
        }
    }
}

struct TransactionsTabView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsTabView()
    }
}
