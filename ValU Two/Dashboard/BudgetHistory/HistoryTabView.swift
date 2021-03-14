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
    @State var showStatsView = true
    init(viewModel: HistoryViewModel){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
    
    }
    
    var body: some View {
        ScrollView{
            
            LazyVStack{
                
                Button(action: {
                    // What to perform
                    withAnimation{
                        self.showStatsView.toggle()
                    }
                }) {
                    HStack{
                            SectionHeader(title: "Stats", image: "chart.pie")
                            
                        
                        Image(systemName: "chevron.right").font(.system(size: 20)).foregroundColor(AppTheme().themeColorPrimary).rotationEffect(.degrees(showStatsView ? 90 : 0))
                        Spacer()
                    }.padding(.top).padding(.horizontal)
                }.buttonStyle(PlainButtonStyle())
                
                
                
                if showStatsView{
                    HistoryStatsView(service : self.viewModel.service).padding(.horizontal).padding(.bottom, 10)
                }
                
                Divider().padding(.leading).padding(.top, 10)
                
                
                
                
                HStack{
                    

                    
                    VStack(alignment: .leading, spacing: 2){
                        SectionHeader(title: "Past Budgets", image: "clock")
                        //Text("SINCE USING VALU TWO").font(.caption).foregroundColor(Color(.gray)).padding(.leading, 25)
                    }
                    Spacer()
                }.padding(.top).padding(.horizontal)
                
                PastBudgetsView(viewModel: self.viewModel)
                
            }
            
            
            
            
            
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


