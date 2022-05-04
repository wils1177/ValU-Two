//
//  HistoryTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoryTabView: View {
    
    @ObservedObject var viewModel : HistoryViewModel
    @State var showStatsView = true
    
    @State private var selection = 0
    
    @State var historyGraphState : HistoryGraphViewState = .All
    @State var historyGraphSection : BudgetSection? = nil
    
    init(viewModel: HistoryViewModel){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
    
    }
    
    
        
    func changeToSection(section: BudgetSection){
        
    }
    
    func changeToAll(){
        
    }
    
    func changeToOther(){
        
    }
    
    var categorySelector: some View{
        VStack{
            if self.viewModel.activeBudget != nil{
                ScrollView(.horizontal){
                    
                    HStack(spacing: 5){
                        
                        Button(action: {
                            // What to perform
                            self.historyGraphState = .All
                            self.historyGraphSection = nil
                        }) {
                            // How the button looks like
                            NavigationBarTextIconButton(text: "All", icon: "globe", color: Color.gray)
                        }
                        
                        
                        
                        
                        
                        
                        ForEach(self.viewModel.activeBudget!.getBudgetSections(), id: \.self){ section in
                            
                            Button(action: {
                                // What to perform
                                self.historyGraphState = HistoryGraphViewState.Section
                                self.historyGraphSection = section
                            }) {
                                // How the button looks like
                                NavigationBarTextIconButton(text: section.name!, icon: section.icon!, color: colorMap[Int(section.colorCode)])
                            }
                            
                            
                        }
                        
                        
                        Button(action: {
                            // What to perform
                            self.historyGraphState = .Other
                            self.historyGraphSection = nil
                        }) {
                            // How the button looks like
                            NavigationBarTextIconButton(text: "Other", icon: "book", color: globalAppTheme.otherColor)
                        }
                        
                        
                    }.padding(.horizontal, 5).padding(.vertical, 5)
                }
            }
        }
    }
    
    var body: some View {
        List{
            
            /*
            HStack{
                Text("Spending by Category").font(.system(size: 23, design: .rounded)).fontWeight(.bold).foregroundColor(Color(.black)).listRowSeparator(.hidden)
                Spacer()
                
               
                
            }.padding(.horizontal).padding(.top)
            */
            
            
            
            VStack(alignment: .leading, spacing: 10){
                
                HStack{
                    Text("Overview").font(.system(size: 23, design: .rounded)).fontWeight(.bold).listRowSeparator(.hidden)
                    Spacer()
                    
                   
                    
                }
                
                
                Picker("", selection: $selection) {
                                Text("Spending").tag(0)
                                Text("Cash Flow").tag(1)
                                
                            }
                .pickerStyle(.segmented).padding(.bottom, 15)
                
                
                
                if self.selection == 0{
                    HistoryGraphView(bars: self.viewModel.createSpendingGraphData(state: self.historyGraphState, budgetSection: self.historyGraphSection).reversed(), selectedBar: nil)
                    
                    categorySelector.padding(.top, 35)
                }
                else{
                    HistoryGraphView(bars: self.viewModel.createCashFlowData().reversed(), sideBySide: true)
                    
                    HStack{
                        
                        NavigationBarTextIconButton(text: "Income", icon: "arrow.up", color: Color(.systemGreen))
                        
                        NavigationBarTextIconButton(text: "Spending", icon: "arrow.down", color: Color(.systemRed))
                        
                    }.padding(.top, 35)
                }
                
                
                
                
            }.listRowSeparator(.hidden).listRowBackground(Color.clear).padding(.horizontal).padding(.vertical, 10).background(Color(.tertiarySystemBackground)).cornerRadius(25).padding(.top, 20).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            
            
            

            
                
                PastBudgetsView(viewModel: self.viewModel)
                
            
            
            
            
            
            
            /*
            HStack{
                Spacer()
                Button(action: {
                    // What to perform
                    self.viewModel.testBudgetCopy()
                }) {
                    // How the button looks like
                    Text("Test Budget Copy")
                }
                Spacer()
            }
            */
            
            
        }
        .background(Color(.systemGroupedBackground))
        
        .navigationBarTitle("History")
    }
}


