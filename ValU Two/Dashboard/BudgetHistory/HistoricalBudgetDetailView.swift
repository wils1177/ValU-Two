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
            VStack{
                
                //savingsStatus.padding()

                
                Divider().padding(.leading)
                
                
                SectionHeader(title: "Spending", image: "arrow.down.circle").padding(.top ,5).padding(.horizontal).padding(.top)
                
                HStack{
                    Text(CommonUtils.makeMoneyString(number: self.service.getSpentAmount(budget: self.budget))).font(.system(size: 35, design: .rounded)).bold()
                    Spacer()
                }.padding(.leading).padding(.bottom, 9).padding(.top)
                
                BudgetStatusBarView(viewData: self.service.getBudgetStatusBarViewData(budget: self.budget))
                
                Divider().padding(.leading)
                
                SectionHeader(title: "Income", image: "arrow.up.circle").padding(.top ,5).padding(.horizontal).padding(.bottom, 10)

                
                IncomeSectionView(coordinator: nil, service: self.transactionsService, budget: self.budget).padding(.bottom)
                
                Divider().padding(.leading)

                SectionHeader(title: "Budgets", image: "creditcard").padding(.top ,5).padding(.horizontal)
                SpendingCardView(budget: self.budget, budgetTransactionsService: self.transactionsService).padding(.horizontal).padding(.bottom)
            }
        }.navigationTitle(self.title)
        
    }
}

