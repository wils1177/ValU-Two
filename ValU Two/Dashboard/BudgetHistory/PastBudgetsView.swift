//
//  PastBudgetsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/8/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct PastBudgetsView: View {
    
    var budgets: [Budget]
    var viewModel: BudgetsViewModel
    
    
    func historyZeroState() -> some View{
        return HStack{
            Text("Budgets will appear here after they're completed").foregroundColor(Color(.lightGray))
            Spacer()
        }.padding(.horizontal).padding(.bottom)
    }
    
    var body: some View {
        List{
            VStack(spacing: 0){
                
                if budgets.count > 0 {
                    ForEach(self.budgets, id: \.self) { budget in
                        VStack(spacing: 0){
                            HistoryEntryView(budget: budget)
                        }
                    }
                }
                else{
                    historyZeroState()
                }
                
                
            }
            }.padding(.top).navigationBarTitle("History")
        
    }
}


