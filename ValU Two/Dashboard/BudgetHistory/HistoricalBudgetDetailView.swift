//
//  HistoricalBudgetDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/1/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoricalBudgetDetailView: View {
    
    var budget: Budget
    var service: BudgetStatsService
    var transactionsService : BudgetTransactionsService
    
    var title : String
    
    var spendingCardViewModel : SpendingCardViewModel
    
    @State var budgetFilter: BudgetFilter = .Spending
    
    init(budget: Budget, service: BudgetStatsService, title: String){
        self.title = title
        self.budget = budget
        self.service = service
        let thetransactionsService = BudgetTransactionsService(budget: budget)
        self.transactionsService = thetransactionsService
        self.spendingCardViewModel = SpendingCardViewModel(budget: budget, budgetTransactionsService: thetransactionsService)
        
    }
    

    
    var savingsStatus: some View{
        HStack{
            Spacer()
            Image(systemName: "checkmark").font(.system(size: 30)).foregroundColor(Color(.systemGreen))
            Text("You hit your savings goal!").font(.system(size: 25, design: .rounded)).bold().foregroundColor(Color(.systemGreen))
            Spacer()
        }
    }
    
    var body: some View {
        ScrollView{
                
            HistoryEntryView(budget: self.budget, service: self.service, coordinator: nil).listRowBackground(Color.clear).listRowSeparator(.hidden).padding().background(Color(.systemGroupedBackground)).cornerRadius(13)
            
            
            VStack(alignment: .leading, spacing: 6){
                
                Text("This Month vs Last Month").font(.system(size: 21, weight: .bold, design: .rounded)).padding(.leading, 5).padding(.bottom, 5)
                
                ThisMonthLastMonthGraph(budget: self.budget
                                        , budgetTransactionsService: self.transactionsService, budgetFilter: $budgetFilter).listRowBackground(Color.clear).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowSeparator(.hidden)
            }.padding(10).background(Color(.tertiarySystemBackground)).cornerRadius(12).padding([.horizontal, .bottom], 16)
                
                
                
                
            SpendingCardView(budget: self.budget, budgetTransactionsService: self.transactionsService, budgetFilter: self.$budgetFilter).listRowSeparator(.hidden).listRowBackground(Color.clear)
            
            
            
            
        }.background(Color(uiColor: .systemGroupedBackground))
        
    }
}

