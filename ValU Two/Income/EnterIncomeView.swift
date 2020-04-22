//
//  IncomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/15/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EnterIncomeView: View {
    
    var budget: Budget
    var coordinator : IncomeCoordinator
    @ObservedObject var incomeService : BudgetIncomeService
    
    var errorString = "Please enter a non-zero income"
    
    
    init(coordinator: IncomeCoordinator, budget: Budget){
        self.budget = budget
        self.coordinator = coordinator
        self.incomeService = BudgetIncomeService(budget: budget)
    }
    
    var errorState: some View{
        VStack{
            if self.incomeService.currentIncomeEntry != "" &&  (self.incomeService.currentIncomeEntry.doubleValue == nil || self.incomeService.currentIncomeEntry.doubleValue == 0.0){
                Text(self.errorString).foregroundColor(Color(.systemRed))
            }
        }
    }
    
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .center){
                    
                    
                Text("Confirm Your Monthly Income").font(.system(size: 23)).bold().lineLimit(2).fixedSize(horizontal: false, vertical: true).padding(.horizontal).padding(.top).padding(.top)
                Text("Set the income to use for your budget.").font(.system(size: 21)).bold().foregroundColor(Color(.lightGray)).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).padding(.horizontal).padding()
                    
                    CustomInputTextField(text: self.$incomeService.currentIncomeEntry, placeHolderText: "Your Income", textSize: .systemFont(ofSize: 28), alignment: .center, delegate: nil, key: nil)
                    .padding(.horizontal, 25)
                .frame(width: 310, height: 60).background(Color(.systemGroupedBackground)).cornerRadius(15)
                    
                    errorState
            
                
                
                Spacer().padding(.bottom, 25)
                
                if self.incomeService.getIncomeTransactions().count > 0{
                    VStack{
                        Text("Estimate based on your previous month's income").font(.system(size: 21)).bold().lineLimit(2).fixedSize(horizontal: false, vertical: true).foregroundColor(Color(.lightGray)).padding(.horizontal).padding()
                        
                        VStack{
                            IncomeTransactionsView(incomeService: self.incomeService).padding().padding(.horizontal)
                        }
                    }
                }
                
                
                
            

            
            
            }
        }.navigationBarTitle("Income").navigationBarItems(
                                                                       
                                                                       
                    trailing: Button(action: {
                        if self.incomeService.currentIncomeEntry.doubleValue != nil && self.incomeService.currentIncomeEntry.doubleValue != 0.0{
                            self.incomeService.tryToSetBudgetIncome()
                            self.coordinator.incomeSubmitted(budget: self.budget)
                        }
                    }){
                    ZStack{
                        if self.incomeService.currentIncomeEntry.doubleValue != nil && self.incomeService.currentIncomeEntry.doubleValue != 0.0{
                            Text("Confirm").bold()
                        }
                        else{
                            Text("Confirm").foregroundColor(Color(.lightGray))
                        }
                        
                    }
            })
        
    }
}


