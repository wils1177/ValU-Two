//
//  HistoryEntryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoryEntryView: View {
    
    var budget : Budget
    var service : BudgetStatsService
    var coordinator : HistoryTabCoordiantor?
    
    var amountSaved : Int
    var amountSpent : Int
    
    var amountEarned : Int
    
    init(budget: Budget, service: BudgetStatsService, coordinator: HistoryTabCoordiantor?){
        self.budget = budget
        self.service = service
        self.coordinator = coordinator
        self.amountSaved = service.getAmountSavedForBudget(budget: budget)
        self.amountSpent = service.getSpentAmount(budget: self.budget)
        self.amountEarned = service.getEarnedAmount(budget: self.budget)
    }
    


    
    func getStartDate() -> String{
        let date = self.budget.startDate!
        let df = DateFormatter()
        df.dateFormat = "MM/dd"
        return df.string(from: date)
    }
    
    func getEndDate() -> String{
        let date = self.budget.endDate!
        let df = DateFormatter()
        df.dateFormat = "MM/dd"
        return df.string(from: date)
    }
    
    func getIcon() -> some View{
        if self.service.didHitSavingsGoal(budget: self.budget){
            return AnyView(Image(systemName: "checkmark.circle.fill").font(.system(size: 35)).padding(.trailing, 10).foregroundColor(Color(.systemGreen)))
        }
        else{
            return AnyView(Image(systemName: "xmark.shield.fill").font(.system(size: 35)).padding(.trailing, 10).foregroundColor(Color(.systemGray)))
        }
    }
    
    var hitGoal : some View{
        HStack{
            Spacer()
            Text("Savings Goal Hit - Saved " + CommonUtils.makeMoneyString(number: self.service.getAmountSavedForBudget(budget: self.budget))).font(.headline).foregroundColor(Color(.systemGreen)).bold()
            Spacer()
        }.padding(.vertical, 7).background(Color(.systemGreen).opacity(0.3))
    }
    
    var savedSome : some View {
        HStack{
            Spacer()
            Text("Missed Savings Goal - Saved " + CommonUtils.makeMoneyString(number: self.service.getAmountSavedForBudget(budget: self.budget))).font(.headline).foregroundColor(Color(.systemGray)).bold()
            Spacer()
        }.padding(.vertical, 7).background(Color(.systemGray).opacity(0.3))
    }
    
    var lostMoney : some View {
        HStack{
            Spacer()
            Text("Missed Savings Goal - Lost " + CommonUtils.makeMoneyString(number: self.service.getAmountSavedForBudget(budget: self.budget))).font(.headline).foregroundColor(Color(.systemYellow)).bold()
            Spacer()
        }.padding(.vertical, 7).background(Color(.systemYellow).opacity(0.3))
    }
    
    @ViewBuilder
    var footer : some View {
        
        if self.amountSaved >= Int((Float(self.amountSpent) * self.budget.savingsPercent)){
            hitGoal
        }
        else if self.amountSaved <= 0{
            lostMoney
        }
        else{
            savedSome
        }
        
    }
    

    var body: some View {
        
        Button(action: {
            // What to perform
            self.coordinator?.showBudgetDetail(budget: self.budget, service: self.service, title: (getStartDate() + " - " + getEndDate()))
        }) {
            // How the button looks like
            
            VStack{
                
                
                
                VStack(spacing: 0){
                    HStack{
                        Text(getStartDate() + " - " + getEndDate()).font(.system(size: 20, design: .rounded)).fontWeight(.bold).lineLimit(1)
                        Spacer()
                    }.padding(.horizontal).padding(.top, 15)
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 2){
                            
                            HStack(spacing:2){
                                Text("Spent").font(.system(size: 15, design: .rounded)).fontWeight(.heavy).foregroundColor(Color(.systemRed)).lineLimit(1)
                            }
                            
                            Text(CommonUtils.makeMoneyString(number: self.amountSpent)).font(.system(size: 31, design: .rounded)).bold()
                            
                            
                        }
                        
                        Spacer()
                        VStack(alignment: .leading, spacing: 2){
                            
                            HStack(spacing:2){
                                Text("Earned").font(.system(size: 15, design: .rounded)).fontWeight(.heavy).foregroundColor(Color(.systemGreen)).lineLimit(1)
                            }
                            
                            Text(CommonUtils.makeMoneyString(number: self.amountEarned)).font(.system(size: 31, design: .rounded)).bold()
                            
                            
                            
                        }
                        
                    }.padding(.horizontal, 40).padding(.vertical, 10).padding(.bottom, 5)
                    
            
                    
                    self.footer
                }.background(Color(.tertiarySystemBackground)).cornerRadius(20).shadow(radius: 5).padding()
                
            }
            
            
            
        }.buttonStyle(PlainButtonStyle())
        
        
        
        
        
    }
}


