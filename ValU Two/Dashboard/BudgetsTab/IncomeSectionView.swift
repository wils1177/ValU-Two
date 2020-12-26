//
//  IncomeSectionView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeSectionView: View {
    var model : BudgetTransactionsService

    var income : String
    var expenses: String
    var coordinator : BudgetsTabCoordinator?
    
    init(coordinator: BudgetsTabCoordinator?, service : BudgetTransactionsService){
        self.model = service
        self.income = CommonUtils.makeMoneyString(number: (Int(model.getBudgetIncome() * -1)))
        self.expenses = CommonUtils.makeMoneyString(number: (Int(model.getBudgetExpenses())))
        
        self.coordinator = coordinator
    }
    
    
    var incomePortion : some View{
        VStack(alignment: .center){
            HStack{
                Image(systemName: "chevron.up.circle.fill").foregroundColor(Color(.systemGreen)).font(.system(size: 27))
                Spacer()
                Text(self.income).font(.system(size: 24)).fontWeight(.bold).lineLimit(1)
                
                
            }
            HStack{
                Text("Earned").font(.system(size: 17)).bold().foregroundColor(Color(.lightGray))
                Spacer()
            }.padding(.top, 2)
            
            //Text("This Month").font(.callout).bold().foregroundColor(Color(.lightGray))
            //Text("Up $400").font(.callout).foregroundColor(Color(.lightGray))
        }.padding().background(Color(.white)).cornerRadius(15)//.padding(.vertical, 5)
    }
    
    var expensesPortion : some View{
        VStack(alignment: .center){
            HStack{
                //Circle().frame(width: 7, height: 7).foregroundColor(Color(.systemRed))
                Image(systemName: "chevron.down.circle.fill").foregroundColor(Color(.systemRed)).font(.system(size: 27))
                Spacer()
                Text(self.expenses).font(.system(size: 24)).fontWeight(.bold).lineLimit(1)
                
            }
            
            HStack{
                Text("Spent").font(.system(size: 17)).bold().foregroundColor(Color(.lightGray))
                Spacer()
            }.padding(.top, 2)
            
            //Text("This Month").font(.callout).bold().foregroundColor(Color(.lightGray))
            //Text("Up $400").font(.callout).foregroundColor(Color(.lightGray))
        }.padding().background(Color(.white)).cornerRadius(15)//.padding(.vertical, 5)
    }
    
    
    var card : some View{
        VStack(spacing: 0){
            
            
            HStack{
                //Spacer()
                Button(action: {
                    self.coordinator?.showIncome(transactions: self.model.getIncomeTransactions())
                }) {
                    incomePortion
                }.buttonStyle(PlainButtonStyle())
                
                Spacer()
                Button(action: {
                    self.coordinator?.showExpenses(transactions: self.model.getExpenseTransactions())
                }) {
                    expensesPortion
                }.buttonStyle(PlainButtonStyle())
                
                
                //Spacer()
                
            }
            
        }
    }
    
    
    var body: some View {
        
        self.card
        
        /*
        Button(action: {
            self.coordinator?.showCashFlow(viewModel: self.viewModel)
        }) {
            
        }.buttonStyle(PlainButtonStyle())
        */
    }
}


