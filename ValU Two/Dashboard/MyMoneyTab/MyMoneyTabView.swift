//
//  MyMoneyTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI
import Charts



struct MyMoneyTabView: View {
    
    @ObservedObject var viewModel : MyMoneyViewModel
    var coordinator : MoneyTabCoordinator?
    
    @State private var selection = 0
    
    func getDaysAway() -> Int{
        
        if selection == 0 {
            return -365
        }
        if selection == 1{
            return -30
        }
        else if selection == 2{
            return -7
        }
        else{
            return -7
        }
        
        
    }
    
    
    
    func getGraphHistory() -> [BalanceHistoryTotal]{
        
        let start = Calendar.current.date(byAdding: .day, value: getDaysAway(), to: Date())!
        print(BalanceHistoryService().getTotalBalanceHistoryforDateRange(startDate: start, endDate: Date()))
        return BalanceHistoryService().getTotalBalanceHistoryforDateRange(startDate: start, endDate: Date())
        
    }
    
    var graph: some View{
        VStack(alignment: .leading){
            
            
            
            Text("Balance History").font(.system(size: 21, design: .rounded)).fontWeight(.semibold)
            
            
            
            HStack{
                VStack(alignment: .leading){
                    
                    
                    Picker("", selection: $selection) {
                                    Text("Year").tag(0)
                                    Text("Month").tag(1)
                                    Text("Week").tag(2)
                                    
                                    
                                }
                                .pickerStyle(.segmented)
                }
                Spacer()
                
                
            }
            
            Chart{
                
                
                ForEach(self.getGraphHistory().sorted {$0.date < $1.date}) { entry in
                    LineMark(x: .value("Date", entry.date), y: .value("Balance", entry.balanceTotal)).lineStyle(StrokeStyle(lineWidth: 5)).foregroundStyle(globalAppTheme.themeColorPrimary.gradient).interpolationMethod(.catmullRom)
                }
                 
                
                /*
                ForEach(getGraphHistory().sorted {$0.date < $1.date}) { entry in
                    AreaMark(x: .value("Date", entry.date), y: .value("Balance", entry.balanceTotal)).foregroundStyle(globalAppTheme.themeColorPrimary.gradient.opacity(0.15))
                }
                */
                
                
                
            }
            .chartYScale(domain: .automatic(includesZero: false))
            .chartYAxis {
                AxisMarks(values: .automatic(minimumStride: 5, desiredCount: 6, roundLowerBound: false)) { value in
                    AxisValueLabel("$\(value.as(Double.self)!.formatted())")
                    AxisTick()
                    AxisGridLine()
                }
            }
            .frame(height: 220).padding(.vertical)
            
            
        }.listRowSeparator(.hidden)
        
    }
    
   
    
    var body: some View {
         
            List{
                
                
                
                BalanceSummaryView().padding(.horizontal, 5).padding(.top, 25).listRowBackground(Color.clear).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowBackground(Color.clear).listRowSeparator(.hidden)
                
                //CashFlowHighlightView().padding(.horizontal, 5).padding(.top, 5)
                
                Section{
                    graph
                }
                
                
                Section(header: Text("Accounts").font(.system(size: 17, design: .rounded)).fontWeight(.semibold)){
                    SwiftUIAccountsView(coordinator: self.coordinator)
                }
                
                
            }
            
            .refreshable {
                let refreshModel = OnDemandRefreshViewModel()
                await refreshModel.refreshAllItems()
            }
        
            .background(Color(.systemGroupedBackground))
        .navigationBarTitle("Accounts")
    }
}


