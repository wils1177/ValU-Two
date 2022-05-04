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
    @ObservedObject var predictionService: IncomePredictionService
    
    var errorString = "Please enter a non-zero income"
    
    
    init(coordinator: IncomeCoordinator, budget: Budget){
        self.budget = budget
        self.coordinator = coordinator
        let budgetService = BudgetIncomeService(budget: budget)
        self.incomeService = budgetService
        self.predictionService = budgetService.incomePredictionService
    }
    
    var errorState: some View{
        VStack{
            
            if !self.incomeService.isValidState() {
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
            VStack(alignment: .center){
                
                VStack(alignment: .center, spacing: 10){
                    //Text(self.header).font(.system(size: 15, design: .rounded)).bold().lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.lightGray))
                        
                    Text("Enter your " + self.getTimeFrameText() + " Income").font(.system(size: 27, design: .rounded)).fontWeight(.heavy).lineLimit(1).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)

                    Text("This will inform how much you have avilable to spend in your budget.").font(.system(size: 16, design: .rounded)).lineLimit(3).multilineTextAlignment(.center).foregroundColor(Color(.gray))
                }.offset(y: -12)
                
                
          
                    
                VStack (alignment: .center){
                    
                    if self.incomeService.getIncomeTransactions().count > 0{
                        
                        Button(action: {
                            // What to perform
                            self.coordinator.showIncomeTransactions(service: self.incomeService)
                        }) {
                            HStack(spacing: 3){
                                Image(systemName: "info.circle.fill").font(.system(size: 15, weight: .semibold, design: .rounded))
                                Text("Estimated Income: \(Text(CommonUtils.makeMoneyString(number: Int(self.incomeService.incomePredictionService.getTotalIncome())))) ").font(.system(size: 17, weight: .semibold, design: .rounded)).foregroundColor(AppTheme().themeColorPrimary).bold()
                            }
                            
                        }.padding(.bottom)
                        
                        
                        
                        
                    }
                    
                    
                        //CustomInputTextField(text: self.$incomeService.currentIncomeEntry, placeHolderText: "$0", textSize: .systemFont(ofSize: 60), alignment: .center, delegate: nil, key: nil)
                            //.padding(.horizontal)
                    
                    TextField("$0", text: self.$incomeService.currentIncomeEntry).font(.system(size: 60, weight: .semibold, design: .rounded)).multilineTextAlignment(.center).foregroundColor(AppTheme().themeColorPrimary).keyboardType(.numberPad).padding(.top, 20)
                        
                    
                    
                        
                        errorState
                    
                    Text("Tap to enter your income. ").font(.caption).lineLimit(3).multilineTextAlignment(.center).foregroundColor(Color(.gray)).padding(.top, 10)
                }.padding(.bottom, 30).padding(.top, 15)
                    
                
                
                
                
            
            
            }.padding(.horizontal)
            
            Spacer()
            if self.incomeService.isValidState(){
                Button(action: {
                              //Button Action
                    
                        self.incomeService.tryToSetBudgetIncome()
                        self.coordinator.incomeSubmitted(budget: self.budget)
                    
                              }){
                                  ActionButtonLarge(text: "Done", enabled: true).padding().padding(.horizontal)
                
                          }
            }
            else{
                ActionButtonLarge(text: "Done", enabled: false).padding().padding(.horizontal)
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
        VStack(alignment: .leading, spacing: 10){
            //Text(self.header).font(.system(size: 15, design: .rounded)).bold().lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.lightGray))
                
            Text(self.title).font(.system(size: 27, design: .rounded)).bold().lineLimit(1).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)

            Text(self.description).font(.system(size: 16, design: .rounded)).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.gray))
        }.offset(y: -12)
        
    }
}


