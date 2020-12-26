//
//  HistoryTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoryTabView: View {
    
    @ObservedObject var viewModel : HistoryViewModel
    
    init(viewModel: HistoryViewModel){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
    
    }
    
    var body: some View {
        List{
            
            HStack{
                VStack(alignment: .leading){
                    Text("Statistics").font(.system(size: 22)).bold()
                    Text("SINCE USING VALU TWO").font(.caption).foregroundColor(Color(.gray)).padding(.top, 3)
                }
                Spacer()
            }.padding(.leading, 10)
            
            
            HistoryStatsView(service : self.viewModel.service).padding(.horizontal, 5)
            
            HStack{
                VStack(alignment: .leading){
                    Text("Past Budgets").font(.system(size: 22)).bold()

                }
                Spacer()
            }.padding(.leading, 10).padding(.top)
            
            PastBudgetsView(viewModel: self.viewModel)
            
            /*
            HStack{
                Spacer()
                Button(action: {
                    // What to perform
                    self.viewModel.testBudgetCopy()
                }) {
                    // How the button looks like
                    Text("Test Budget Copy")
                }
                Spacer()
            }
            */
            
            
        }.listStyle(SidebarListStyle())
        .navigationBarTitle("History")
    }
}


