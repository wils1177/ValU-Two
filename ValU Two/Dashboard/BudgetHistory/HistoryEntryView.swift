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
    
    var amountSaved : String
    var amountSpent : String
    
    var amountEarned : Int
    
    @State var showBar = false
    
    init(budget: Budget, service: BudgetStatsService, coordinator: HistoryTabCoordiantor?){
        self.budget = budget
        self.service = service
        self.coordinator = coordinator
        self.amountSaved = CommonUtils.makeMoneyString(number: service.getAmountSavedForBudget(budget: budget))
        self.amountSpent = CommonUtils.makeMoneyString(number: Int(budget.spent))
        self.amountEarned = service.getEarnedAmount(budget: self.budget)
    }
    
    func getBudgetName() -> String{
        let monthInt = Calendar.current.component(.month, from: self.budget.startDate!) // 4
        let monthStr = Calendar.current.monthSymbols[monthInt-1]  // April
        
        let dayInt = Calendar.current.component(.day, from: self.budget.startDate!) // 4
        let dayStr = String(dayInt)  // April
        
        return monthStr + " " + dayStr
        
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
            Text("Congrats 🎉 ! You beat your budget goal by \(Text("$239").foregroundColor(Color.blue)) and saved \(Text(self.amountSaved).foregroundColor(Color.green))!").font(.system(size: 18, design: .rounded)).fontWeight(.semibold).multilineTextAlignment(.center)
    }
    
    var savedSome : some View {
        Text("Almost! You didn't quite hit your budget goal, but you did save \(Text(self.amountSaved).foregroundColor(Color.green))!").font(.system(size: 18, design: .rounded)).fontWeight(.semibold).multilineTextAlignment(.center)
    }
    
    var lostMoney : some View {
        Text("Darn! You went over budget this month by \(Text(self.amountSaved).foregroundColor(Color.red))!").font(.system(size: 18, design: .rounded)).fontWeight(.semibold).multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    func getBudgetText() -> some View {
        if self.service.didHitSavingsGoal(budget: self.budget){
            self.hitGoal
            
        }
        else{
            if self.service.didSaveAnything(budget: self.budget){
                savedSome
            }
            else{
                lostMoney
            }
        }
    }
   
    
    var barViewData = [
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "doc.text.fill"),
        BudgetStatusBarViewData(percentage: 0.15, color: .blue, name: "Fun", icon: "dot.radiowaves.right"),
        BudgetStatusBarViewData(percentage: 0.15, color: .green, name: "Drugs", icon: "folder.fill"),
        BudgetStatusBarViewData(percentage: 0.15, color: .orange, name: "what", icon: "link.circle.fill"),
        BudgetStatusBarViewData(percentage: 0.15, color: .purple, name: "Other", icon: "moon.zzz"),
        BudgetStatusBarViewData(percentage: 0.25, color: Color(.tertiarySystemGroupedBackground), name: "Other", icon: "pencil")
        
    ]
    

    var body: some View {
        
        Button(action: {
            // What to perform
            //self.coordinator?.showBudgetDetail(budget: self.budget, service: self.service, title: (getStartDate() + " - " + getEndDate()))
            withAnimation{
                self.showBar.toggle()
            }
        }) {
            // How the button looks like
            
            VStack(spacing: 0){
                
                HStack{
                    Image(systemName: "calendar").font(.system(size: 17, design: .rounded)).foregroundColor(AppTheme().themeColorPrimary)
                    Text(getBudgetName()).font(.system(size: 17, design: .rounded)).fontWeight(.semibold).foregroundColor(AppTheme().themeColorPrimary)
                    Spacer()
                    
                    Image(systemName: "chevron.right").font(.system(size: 17, design: .rounded)).foregroundColor(AppTheme().themeColorPrimary).rotationEffect(.degrees(showBar ? 90 : 0))
                    
                    
            
                }.padding(.horizontal).padding(.top, 10).padding(.bottom, 13)
                
                HStack{
                    Text("\(self.amountSpent)\(Text(" / \(self.service.getAvailableString(budget: self.budget))").foregroundColor(Color(.lightGray)).font(.system(size: 22, design: .rounded)))").font(.system(size: 30, design: .rounded)).fontWeight(.bold)
                    Spacer()
                }.padding(.bottom, 12).padding(.horizontal)
                
                if self.showBar{
                    BudgetStatusBarView(viewData: self.service.getBudgetStatusBarViewData(budget: self.budget), showLegend: true).padding(.horizontal)
                    
                    
                }
                
                HStack(){
                    getBudgetText()
                }.padding(8).padding(.horizontal, 7).background(AppTheme().themeColorPrimary.opacity(0.1)).cornerRadius(15).padding(.horizontal, 5).padding(.bottom)
                
            
            
                
                    
                
                
 
                
            }.background(Color(.systemBackground)).cornerRadius(25)
                
            }.buttonStyle(PlainButtonStyle())
            
            
            
        }
        
        
        
        
        
    
}


