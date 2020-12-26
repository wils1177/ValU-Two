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
    
    func getTimeFrameText() -> String{
        if budget.timeFrame == 0{
            return "Monthly"
        }
        else if budget.timeFrame == 1{
            return "Semi-Monthly"
        }
        else{
            return "Weekly"
        }
    }
    
    
    var body: some View {
        
        List{
            VStack(alignment: .leading){
                    
                HStack{
                    Spacer()
                    Text("Enter Your " + self.getTimeFrameText() + " Income").font(.system(size: 32)).bold().lineLimit(2).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center).padding(.bottom,25)
                    Spacer()
                }
                
                
               /*
                HStack{
                    Spacer()
                    Text("This is the available income you will use for your budget.").multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }.padding(.bottom, 25)
                */
                
                HStack{
                    Spacer()
                    Text("We've estimted you income based on your previous transactions, as a starting point.").multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }.padding(.bottom, 25)
                    
                
                
                    
                VStack{
                    CustomInputTextField(text: self.$incomeService.currentIncomeEntry, placeHolderText: "Your Income", textSize: .systemFont(ofSize: 27), alignment: .center, delegate: nil, key: nil)
                        .padding(.horizontal)
                    .frame(height: 60).background(Color(.lightText)).cornerRadius(10)
                        
                        errorState
                }
                    
            
                
                
                Spacer().padding(.bottom, 30)
                
                if self.incomeService.getIncomeTransactions().count > 0{
                    VStack{
                        
                        HStack{
                            Text("Past Income").font(.system(size: 22)).bold().lineLimit(2).fixedSize(horizontal: false, vertical: true).foregroundColor(Color(.black))
                            Spacer()
                        }.padding(.leading)
                        
                        
                        VStack{
                            IncomeTransactionsView(incomeService: self.incomeService).padding(.vertical)
                        }
                    }
                }
                
                
                
            

            
            
            }
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle("").navigationBarItems(
                                                                       
                                                                       
                    trailing: Button(action: {
                        if self.incomeService.currentIncomeEntry.doubleValue != nil && self.incomeService.currentIncomeEntry.doubleValue != 0.0{
                            self.incomeService.tryToSetBudgetIncome()
                            self.coordinator.incomeSubmitted(budget: self.budget)
                        }
                    }){
                    ZStack{
                        if self.incomeService.currentIncomeEntry.doubleValue != nil && self.incomeService.currentIncomeEntry.doubleValue != 0.0{
                            Text("Confirm").foregroundColor(AppTheme().themeColorPrimary)
                        }
                        else{
                            Text("Confirm").foregroundColor(Color(.lightGray))
                        }
                        
                    }
            })
        
    }
}


