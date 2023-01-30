//
//  ThisMonthLastMonthGraph.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/1/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import SwiftUI
import Charts

struct ThisMonthLastMonthGraph: View {
    
    var budget: Budget
    var budgetTransactionsService: BudgetTransactionsService
    
    
    @Binding var budgetFilter: BudgetFilter
    
    
    
    
    var body: some View {
        VStack(){
            
            
            /*
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
                
                
            }.padding(.bottom, 5)
            */
            
            if budgetFilter == .Spending{
                VStack{
                    
                    NewLineGraph(dataSet1: self.budgetTransactionsService.getThisMonthSpending(), color1: globalAppTheme.themeColorPrimary, dataSet2: self.budgetTransactionsService.getLastMonthSpending(), color2: Color(.lightGray), cutOffValue: self.budgetTransactionsService.getFreeLimit(), cutOffColor: Color(.systemOrange))
                    HStack(spacing: 3){
                        Spacer()
                        Rectangle().frame(width: 20, height: 3).foregroundColor(Color(.systemBlue))
                        Text("This Month").font(.system(size: 13, weight: .semibold, design: .rounded)).padding(.trailing)
                        Rectangle().frame(width: 20, height: 3).foregroundColor(Color(.lightGray))
                        Text("Last Month").font(.system(size: 13, weight: .semibold, design: .rounded)).padding(.trailing)
                        Line()
                            .stroke(Color(.systemOrange), style: StrokeStyle(lineWidth: 2, dash: [4]))
                                   .frame(width:20, height: 2)
                        Text("Budget").font(.system(size: 13, weight: .semibold, design: .rounded))
                        Spacer()
                    }
                }
            }
            else if budgetFilter == .Recurring{
                VStack{
                    
                    if self.budgetTransactionsService.getRecurringBudgetCategories().count > 0{
                        NewLineGraph(dataSet1: self.budgetTransactionsService.getThisMonthRecurring(), color1: globalAppTheme.themeColorPrimary, dataSet2: self.budgetTransactionsService.getLastMonthRecurring(), color2: Color(.lightGray), cutOffValue: self.budgetTransactionsService.getAssumedSpending(), cutOffColor: Color(.systemOrange))
                        HStack(spacing: 3){
                            Spacer()
                            Rectangle().frame(width: 20, height: 3).foregroundColor(globalAppTheme.themeColorPrimary)
                            Text("This Month").font(.system(size: 13, weight: .semibold, design: .rounded)).padding(.trailing)
                            Rectangle().frame(width: 20, height: 3).foregroundColor(Color(.lightGray))
                            Text("Last Month").font(.system(size: 13, weight: .semibold, design: .rounded)).padding(.trailing)
                            Line()
                                .stroke(Color(.systemOrange), style: StrokeStyle(lineWidth: 2, dash: [4]))
                                       .frame(width:20, height: 2)
                            Text("Budget").font(.system(size: 13, weight: .semibold, design: .rounded))
                            Spacer()
                        }
                    }
                    
                    
                }
            }
            else{
                VStack{
                    //LineView(dataSet1: self.budgetTransactionsService.getThisMonthIncome(), dataSet2: self.budgetTransactionsService.getLastMonthIncome(), cutOffValue: Double(self.budget.amount), color1: Color(.systemGreen), color2: Color(.lightGray).opacity(0.7), cutOffColor: Color(.systemOrange), legendSet: self.budgetTransactionsService.getGraphLabels()).frame(height: 200).padding(.vertical, 10)
                    
                    NewLineGraph(dataSet1: self.budgetTransactionsService.getThisMonthIncome(), color1: Color(.systemGreen), dataSet2: self.budgetTransactionsService.getLastMonthIncome(), color2: Color(.lightGray), cutOffValue: Double(self.budget.amount), cutOffColor: Color(.systemOrange))
                    
                    HStack(spacing: 3){
                        Spacer()
                        Rectangle().frame(width: 25, height: 3).foregroundColor(Color(.systemGreen))
                        Text("This Month").font(.system(size: 13, weight: .semibold, design: .rounded)).padding(.trailing)
                        Rectangle().frame(width: 25, height: 3).foregroundColor(Color(.lightGray))
                        Text("Last Month").font(.system(size: 13, weight: .semibold, design: .rounded)).padding(.trailing)
                        Line()
                            .stroke(Color(.systemOrange), style: StrokeStyle(lineWidth: 4, dash: [5]))
                                   .frame(width:25, height: 2)
                        Text("Typical").font(.system(size: 13, weight: .semibold, design: .rounded))
                        Spacer()
                    }
                }
            }
            
            
            
            
            
            
                  
        }
    }
}

struct NewLineGraph : View{
    
    var dataSet1: [BalanceHistoryTotal]
    var color1: Color
    var dataSet2: [BalanceHistoryTotal]
    var color2: Color
    var cutOffValue: Double
    var cutOffColor: Color
    
    func subtractMonth(date: Date) -> Date {
        Calendar.current.date(byAdding: .month, value: 1, to: date)!
    }
    
    var body: some View {
        Chart{
            
            RuleMark(
                y: .value("Budget", self.cutOffValue)
            ).foregroundStyle(cutOffColor)
                .lineStyle(StrokeStyle(lineWidth: 3, dash: [5]))
            .annotation(position: .overlay, alignment: .leading){
                ZStack{
                    Capsule().frame(width: 65, height: 20).foregroundColor(cutOffColor)
                    Text(CommonUtils.makeMoneyString(number: Int(self.cutOffValue))).foregroundColor(Color(.white)).font(.system(size: 13, weight: .semibold, design: .rounded))
                }
            }
            
            
            
            ForEach(dataSet2) { data in
                LineMark(x: .value("Date", subtractMonth(date: data.date)), y: .value("Balance", data.balanceTotal), series: .value("Last Month", "Last Month")).interpolationMethod(.monotone).lineStyle(StrokeStyle(lineWidth: 5)).foregroundStyle(color2.opacity(0.6))
                }
            
            ForEach(dataSet1) { data in
                                LineMark(x: .value("Date", data.date), y: .value("Balance", data.balanceTotal), series: .value("This Month", "This Month")).interpolationMethod(.monotone).lineStyle(StrokeStyle(lineWidth: 5)).foregroundStyle(LinearGradient(gradient: Gradient(colors: [color1, globalAppTheme.themeColorSecondary]), startPoint: .leading, endPoint: .trailing))
                    
                
                AreaMark(x: .value("Date", data.date), y: .value("Balance", data.balanceTotal), series: .value("This Month", "This Month")).foregroundStyle(color1.gradient).opacity(0.1)
                
                }
            
            
            PointMark(x: .value("Date", dataSet1.last!.date), y: .value("Balance", dataSet1.last!.balanceTotal))
                .symbolSize(120)
                .foregroundStyle(color1.gradient)
                .annotation(position: .top, alignment: .center){
                    Text(CommonUtils.makeMoneyString(number: Int(dataSet1.last!.balanceTotal))).font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(color1)
                }
            
            //LineMark(x: .value("Date", data.date), y: .value("Balance", data.balanceTotal)).foregroundStyle(Color.blue.gradient)
            //AreaMark(x: .value("Date", data.date), y: .value("Balance", data.balanceTotal)).foregroundStyle(Color.blue.gradient)
            
        }
        //.chartYAxis(.hidden)
        //.chartXAxis(.hidden)
        .frame(height: 240)
    }
}


