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
        
        List{
            VStack(alignment: .center){
                    
                VStack(spacing: 10){
                    /*
                    Text("Confirm Your Monthly Income").font(.title).bold().lineLimit(2).fixedSize(horizontal: false, vertical: true).padding(.top).padding(.bottom)
                    */
                    Text("Set the income to use for your budget.").font(.system(size: 18)).foregroundColor(Color(.lightGray)).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                }
                
                    
                HStack{
                    Spacer()
                    CustomInputTextField(text: self.$incomeService.currentIncomeEntry, placeHolderText: "Your Income", textSize: .systemFont(ofSize: 23), alignment: .left, delegate: nil, key: nil)
                        .padding(.horizontal)
                    .frame(width: 310, height: 45).background(Color(.white)).cornerRadius(10)
                        
                        errorState
                    Spacer()
                }
                    
            
                
                
                Spacer().padding(.bottom, 25)
                
                if self.incomeService.getIncomeTransactions().count > 0{
                    VStack{
                        HStack{
                           Text("Previous Month's Income").font(.system(size: 21)).bold().lineLimit(2).fixedSize(horizontal: false, vertical: true).foregroundColor(Color(.black))
                            Spacer()
                        }
                        
                        
                        VStack{
                            IncomeTransactionsView(incomeService: self.incomeService).padding()
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
                            Text("Confirm")
                        }
                        else{
                            Text("Confirm").foregroundColor(Color(.lightGray))
                        }
                        
                    }
            })
        
    }
}


