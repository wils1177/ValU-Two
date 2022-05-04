//
//  ThisMonthLastMonthGraph.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/1/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ThisMonthLastMonthGraph: View {
    
    var budget: Budget
    var budgetTransactionsService: BudgetTransactionsService
    @State private var selection = 0
    
    var body: some View {
        VStack(){
            
            
            HStack{
                Text("This Month vs Last Month").font(.system(size: 21, design: .rounded)).fontWeight(.bold)
                Spacer()
            }
            
            HStack{
                VStack(alignment: .leading){
                    
                    
                    Picker("", selection: $selection) {
                                    Text("Spending").tag(0)
                                    Text("Income").tag(1)
                                    
                                }
                                .pickerStyle(.segmented)
                }
                Spacer()
                
                
            }
            
            if selection == 0{
                VStack{
                    LineView(dataSet1: self.budgetTransactionsService.getThisMonthSpending(), dataSet2: self.budgetTransactionsService.getLastMonthSpending(), cutOffValue: self.budgetTransactionsService.getFreeLimit(), color1: Color(.systemBlue), color2: Color(.lightGray).opacity(0.7), cutOffColor: Color(.systemOrange), legendSet: self.budgetTransactionsService.getGraphLabels()).frame(height: 200).padding(.vertical, 15)
                    
                    HStack(spacing: 3){
                        Spacer()
                        Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.systemBlue))
                        Text("This Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                        Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.lightGray))
                        Text("Last Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                        Line()
                            .stroke(Color(.systemOrange), style: StrokeStyle(lineWidth: 2, dash: [4]))
                                   .frame(width:25, height: 2)
                        Text("Budget").font(.system(size: 13, weight: .semibold))
                        Spacer()
                    }
                }.padding(.top, 7)
            }
            else{
                VStack{
                    LineView(dataSet1: self.budgetTransactionsService.getThisMonthIncome(), dataSet2: self.budgetTransactionsService.getLastMonthIncome(), cutOffValue: Double(self.budget.amount), color1: Color(.systemGreen), color2: Color(.lightGray).opacity(0.7), cutOffColor: Color(.systemOrange), legendSet: self.budgetTransactionsService.getGraphLabels()).frame(height: 200).padding(.vertical, 10)
                    
                    HStack(spacing: 3){
                        Spacer()
                        Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.systemGreen))
                        Text("This Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                        Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.lightGray))
                        Text("Last Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                        Line()
                                   .stroke(style: StrokeStyle(lineWidth: 4, dash: [5]))
                                   .frame(width:25, height: 4)
                        Text("Typical Income").font(.system(size: 13, weight: .semibold))
                        Spacer()
                    }
                }.padding(.top, 10)
            }
            
            
            
            
            
            
                  
        }.padding(12).background(Color(.tertiarySystemBackground)).cornerRadius(25).padding(.horizontal).padding(.bottom)
    }
}


