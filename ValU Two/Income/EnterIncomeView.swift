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
        
        VStack{
            VStack(alignment: .leading){
                
                StepTitleText(header: "Step 2 of 4", title: self.getTimeFrameText() + " Income", description: "Enter the income to use for your budget.")
          
                    
                VStack (alignment: .leading){
                    ZStack{
                        CustomInputTextField(text: self.$incomeService.currentIncomeEntry, placeHolderText: "Your Income", textSize: .systemFont(ofSize: 18), alignment: .left, delegate: nil, key: nil)
                            .padding(.horizontal)
                        .frame(height: 45).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(15)
                        HStack{
                            Spacer()
                            Text("USD").foregroundColor(AppTheme().themeColorPrimary).bold().padding(.trailing)
                        }.frame(height: 45)
                    }
                    
                        
                        errorState
                    
                    Text("Tap to enter your income. ").font(.caption).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.gray)).padding(.horizontal).padding(.top, 5)
                }.padding(.bottom, 30).padding(.top, 15)
                
                
                if self.incomeService.getIncomeTransactions().count > 0{
                    
                    Button(action: {
                        // What to perform
                        self.coordinator.showIncomeTransactions(transactions: self.incomeService.getIncomeTransactions())
                    }) {
                        // How the button looks like
                        HStack(alignment: .center){
                            VStack(alignment: .leading, spacing: 5){
                                Text("Estimated Income").font(.headline).foregroundColor(AppTheme().themeColorPrimary).bold()
                                Text(CommonUtils.makeMoneyString(number: Int(self.incomeService.incomePredictionService.getTotalIncome()))).font(.title3)
                                
                            }
                            Spacer()
                            Image(systemName: "ellipsis.circle.fill").foregroundColor(AppTheme().themeColorPrimary).font(.system(size: 28))
                        }.padding().background(Color(.tertiarySystemGroupedBackground)).cornerRadius(15)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Text("Your esimtated income is based from previous transactions over the last 30 days. Tap to see these transactions.").font(.caption).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.gray)).padding(.horizontal)
                }
                
                
            
            
            }.padding(.horizontal)
            
            Spacer()
            if self.incomeService.currentIncomeEntry.doubleValue != nil && self.incomeService.currentIncomeEntry.doubleValue != 0.0{
                Button(action: {
                              //Button Action
                    if self.incomeService.currentIncomeEntry.doubleValue != nil && self.incomeService.currentIncomeEntry.doubleValue != 0.0{
                        self.incomeService.tryToSetBudgetIncome()
                        self.coordinator.incomeSubmitted(budget: self.budget)
                    }
                              }){
                              ActionButtonLarge(text: "Done", enabled: true)
                
                          }
            }
            else{
                ActionButtonLarge(text: "Done", enabled: false)
            }
            
            
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle("")
        
    }
}


struct ColoredActionButton: View {
    
    var text : String
    
    var body: some View {
        ZStack(alignment: .center){
            Capsule().foregroundColor(AppTheme().themeColorSecondary).frame(width: 100, height: 29)
            Text(self.text).foregroundColor(AppTheme().themeColorPrimary).bold()
            
        }
        
    }
}

struct StepTitleText: View {
    
    var header : String
    var title : String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(self.header).font(.system(size: 15)).bold().lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.lightGray))
                
            Text(self.title).font(.system(size: 28)).bold().lineLimit(1).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)

            Text(self.description).font(.system(size: 15)).fontWeight(.semibold).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.gray))
        }.offset(y: -12)
        
    }
}


