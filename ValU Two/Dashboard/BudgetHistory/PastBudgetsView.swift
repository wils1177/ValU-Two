//
//  PastBudgetsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/8/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct PastBudgetsView: View {
    
    @ObservedObject var viewModel : HistoryViewModel
    
    init(viewModel: HistoryViewModel){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        
        //UITableViewCell.appearance().backgroundColor = .clear
        //UITableView.appearance().backgroundColor = .clear
    }
    
    var historyZeroState : some View{
        VStack{
            Image(systemName: "xmark.shield.fill").font(.system(size: 50)).padding(.trailing, 10).foregroundColor(AppTheme().themeColorPrimary).padding(.top).padding(.top)
            Text("No Compelted Budgets Yet").font(.headline).multilineTextAlignment(.center).padding(.top)
            Text("Past budgets will show up here when completed").font(.caption).foregroundColor(Color.gray).multilineTextAlignment(.center)
        }.padding(.bottom).padding(.bottom)
    }
    

    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
                
                if self.viewModel.historicalBudgets.count > 0 {
                    ForEach(viewModel.historicalBudgets, id: \.self) { budget in
                        VStack(spacing: 0){
                            HistoryEntryView(budget: budget, service: self.viewModel.service)
                        }
                    }
                }
                else{
                    HStack{
                        Spacer()
                        historyZeroState.padding(.top)
                        Spacer()
                    }
                    
                }
                
                
            }
            
        
    }
}


