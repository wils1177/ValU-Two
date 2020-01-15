//
//  TransactionList.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
    
    var viewModel : TransactionsListViewModel
    
    init(viewModel: TransactionsListViewModel) {
        
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Transactions").font(.largeTitle).bold()
                Spacer()
            }.padding()
            
            
            ScrollView(){
                ForEach(self.viewModel.viewData, id: \.self){ transaction in
                    TransactionRow(viewModel: transaction)
                }
                
            }
            
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
