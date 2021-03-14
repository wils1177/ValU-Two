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
    var expected : String
    var coordinator : BudgetsTabCoordinator?
    var percentage : Float
    @ObservedObject var budget : Budget
    
    @State var isLarge = false
    
    
    init(coordinator: BudgetsTabCoordinator?, service : BudgetTransactionsService, budget: Budget){
        self.model = service
        let income = model.getBudgetIncome() * -1
        self.income = CommonUtils.makeMoneyString(number: (Int(income)))
        self.budget = budget
        self.percentage = Float(income) / budget.amount
        self.expected = CommonUtils.makeMoneyString(number: Int(budget.amount)) + " Expected"
        self.coordinator = coordinator
    }
    
    func getPercentage() -> Float{
        if self.percentage == 0.0{
            return 0.07
        }
        else if self.percentage > 1.0{
            return 0.93
        }
        else{
            return percentage
        }
    }
    
    var progressBar : some View{
        GeometryReader{ g in
            
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.tertiarySystemGroupedBackground).opacity(0.65)).frame(height: 12).padding(.horizontal)
                RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemGreen)).frame(width: g.size.width * CGFloat(getPercentage()), height: 12).padding(.horizontal)
                
            }.opacity(g.size.height < g.size.width ? 1 : 0)
            
        }.frame(height: 12).clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    
    var mainView : some View {
        VStack(alignment: .leading, spacing: 9){
            
            Button(action: {
                // What to perform
                withAnimation{
                    self.isLarge.toggle()
                }
            }) {
                // How the button looks like
                HStack{
                    SectionHeader(title: "Income", image: "arrow.up.circle")
                    Spacer()
                    
                    if !isLarge{
                        Text(self.income).font(.system(size: 22, design: .rounded)).bold().padding(.trailing)
                    }
                    
                    Image(systemName: "chevron.right").font(.system(size: 20)).foregroundColor(AppTheme().themeColorPrimary).rotationEffect(.degrees(isLarge ? 90 : 0))
                    
                }.padding(.horizontal, 10)
            }.buttonStyle(PlainButtonStyle())
            
            
            if isLarge{
                Button(action: {
                    self.coordinator?.showIncome(transactions: self.model.getIncomeTransactions() )
                }) {
                 HStack(alignment: .bottom){
                     Text(self.income).font(.system(size: 35, design: .rounded)).bold().padding(.leading)
                     
                     Spacer()
                     HStack(spacing: 4){
                         Image(systemName: "arrow.up.circle.fill" ).foregroundColor(AppTheme().themeColorPrimary).font(Font.system(size: 14, weight: .semibold))
                         
                         
                         Text(self.expected).font(.system(size: 16, design: .rounded)).fontWeight(.semibold).foregroundColor(AppTheme().themeColorPrimary)
                     }.padding(4).padding(.horizontal, 10)
                 }.padding(.vertical, 5)
                }.buttonStyle(PlainButtonStyle())
            }
            
            
            
            
            
            
            
            //if isLarge{
            //    self.progressBar.padding(.bottom, 5)
            //}
            
            
            
            /*
            HStack(spacing:2){
                Text("2 Transactions").font(.system(size: 12, design: .rounded)).fontWeight(.heavy).foregroundColor(Color(.systemGreen)).lineLimit(1)
            }.padding(.horizontal, 3).padding(5).background(Color(.systemGreen).opacity(0.3)).cornerRadius(9).padding(.leading)
            */
            
            
            
            
        }
    }
    
    var smallerView : some View{
        VStack(alignment: .leading, spacing: 9){
            
            Button(action: {
                // What to perform
                withAnimation{
                    self.isLarge.toggle()
                }
            }) {
                // How the button looks like
                HStack(){
                    SectionHeader(title: "Income", image: "arrow.up.circle")
                    Spacer()
                    
                    Text(self.income).font(.system(size: 22, design: .rounded)).bold().padding(.trailing)
                    
                    if isLarge{
                        Image(systemName: "chevron.down").font(.system(size: 20)).foregroundColor(AppTheme().themeColorPrimary)
                    }
                    else{
                        Image(systemName: "chevron.right").font(.system(size: 20)).foregroundColor(AppTheme().themeColorPrimary)
                    }
                    
                }.padding(.horizontal, 10)
            }.buttonStyle(PlainButtonStyle())
            
            


        }
    }
    
    
    var body: some View {
        
        mainView
        
        
        
        /*
        Button(action: {
            self.coordinator?.showIncome(transactions: self.model.getIncomeTransactions() )
        }) {
            self.mainView
        }.buttonStyle(PlainButtonStyle())
        */
    }
}


