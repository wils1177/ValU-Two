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
                    SpendingSummaryView()
                }
                else if row.sectionTitle != nil{
                    HStack{
                        Text(row.sectionTitle!).font(.title).fontWeight(.bold)
                        Spacer()
                    }.padding()
                    
                }
                else{
                        TransactionRow(coordinator: self.viewModel.coordinator!, viewData : row.transactionRow!)
                    
                    
                }
                
                
                
            }.navigationBarTitle(Text("Transactions"))
            
            
            
            /*
            ScrollView(){
                SpendingSummaryView().padding(.leading).padding(.trailing)
                
                
                
                
                
                if self.viewModel.transactionsToday!.viewData.count > 0{
                    
                    HStack{
                        Text("Today").font(.title).fontWeight(.bold)
                        Spacer()
                    }.padding()
                    
                    ForEach(self.viewModel.transactionsToday!.viewData, id: \.self){ transaction in
                        
                        NavigationLink(destination: TransactionDetailView(transaction: transaction.rawTransaction)){
                            TransactionRow(viewModel: transaction).padding(.leading).padding(.trailing).padding(.bottom)
                        }.buttonStyle(PlainButtonStyle())
                        
                        
                        
                        
                    }
                }
                
                
                if self.viewModel.transactionsThisWeek!.viewData.count > 0{
                    
                    HStack{
                        Text("Earlier This Week").font(.title).fontWeight(.bold)
                        Spacer()
                    }.padding()
                    
                    ForEach(self.viewModel.transactionsThisWeek!.viewData, id: \.self){ transaction in
                        TransactionRow(viewModel: transaction).padding(.leading).padding(.trailing).padding(.bottom)
                    }
                }
                
                if self.viewModel.transactionsThisMonth!.viewData.count > 0{
                    
                    HStack{
                        Text("Earlier This Month").font(.title).fontWeight(.bold)
                        Spacer()
                    }.padding()
                    
                    ForEach(self.viewModel.transactionsThisMonth!.viewData, id: \.self){ transaction in
                        TransactionRow(viewModel: transaction).padding(.leading).padding(.trailing).padding(.bottom)
                    }
                }
                
                
                */
                
            
                
            
            
        //}
    }
}


