//
//  HistoryGraphView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/31/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import SwiftUI
import Charts

struct HistoryGraphBarSegment: Hashable, Identifiable{
    var id = UUID()
    
    var color: Color
    var name: String
    var startDate: Date
    var value: Double
    var icon: String? = "book"
}

struct HistoryGraphBar: Hashable{
    var label: String
    var totalValue : Double?
    var segments : [HistoryGraphBarSegment]
    var barid = UUID()
}




struct HistoryGraphView: View {
    
    
    @State var historyGraphState : HistoryGraphViewState = .All
    @State var historyGraphSection : BudgetSection?
    
    @State var pickerInt : Int = 0
    
    @ObservedObject var viewModel : HistoryViewModel
    
    
    
    var categorySelector: some View{
        VStack{
            if self.viewModel.activeBudget != nil{
                ScrollView(.horizontal){
                    
                    HStack(spacing: 5){
                        
                        Button(action: {
                            // What to perform
                            withAnimation{
                                self.historyGraphState = .All
                                //self.historyGraphSection = nil
                            }
                            
                        }) {
                            // How the button looks like
                            NavigationBarTextIconButton(text: "All", icon: "globe", color: Color.gray)
                        }
                        
                        
                        
                        
                        
                        
                        ForEach(self.viewModel.activeBudget!.getBudgetSections(), id: \.self){ section in
                            
                            Button(action: {
                                // What to perform
                                withAnimation{
                                    self.historyGraphState = HistoryGraphViewState.Section
                                    self.historyGraphSection = section
                                }
                                
                            }) {
                                // How the button looks like
                                NavigationBarTextIconButton(text: section.name!, icon: section.icon!, color: colorMap[Int(section.colorCode)])
                            }
                            
                            
                        }
                        
                        
                        Button(action: {
                            // What to perform
                            withAnimation{
                                self.historyGraphState = .Other
                                //self.historyGraphSection = nil
                            }
                            
                        }) {
                            // How the button looks like
                            NavigationBarTextIconButton(text: "Other", icon: "book", color: globalAppTheme.otherColor)
                        }
                        
                        
                    }.padding(.horizontal, 5).padding(.vertical, 5)
                }
            }
        }
    }
    
    var body: some View{
        
        VStack{
            
            HStack{
                if historyGraphSection != nil{
                    Text((self.historyGraphSection?.name ?? "All Spending")).font(.system(size: 25, weight: .bold, design: .rounded)).foregroundColor(colorMap[Int(self.historyGraphSection?.colorCode ?? 0)])
                }
                else{
                    Text((self.historyGraphSection?.name ?? "All Spending")).font(.system(size: 25, weight: .bold, design: .rounded))
                }
                
                Spacer()
                Menu() {
                    
                    
                    Picker(selection: $historyGraphSection, label: Text("Budget Section")) {
                        
                        Label("All", systemImage: "globe").tag(nil as BudgetSection?)
                                
                        ForEach(self.viewModel.activeBudget!.getBudgetSections()) { section in
                            Label(section.name!, systemImage: section.icon!).tag(section as BudgetSection?)
                            
                        }
                        
                    }
                    
                }
                label: {
                    
                    HStack(spacing: 3){
                        if historyGraphSection != nil{
                            Image(systemName: self.historyGraphSection?.icon ?? "globe").font(.system(size: 16, weight: .bold, design: .rounded)).foregroundColor(colorMap[Int(self.historyGraphSection?.colorCode ?? 0)])
                            Image(systemName: "chevron.down").font(.system(size: 16, weight: .bold, design: .rounded)).foregroundColor(colorMap[Int(self.historyGraphSection?.colorCode ?? 0)])
                        }
                        else{
                            Image(systemName: self.historyGraphSection?.icon ?? "globe").font(.system(size: 16, weight: .bold, design: .rounded))
                            Image(systemName: "chevron.down").font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        
                    }.padding(.horizontal, 12).padding(.vertical, 6).background(Color(.tertiarySystemGroupedBackground)).clipShape(Capsule())
                    
                }
                
            }
            
            
            
            
            Chart(){
                
                ForEach(self.viewModel.createSpendingGraphData(state: self.historyGraphState, budgetSection: self.historyGraphSection).reversed()) { segment in
                    BarMark(
                        x: .value("Name", CommonUtils.getDateTitle(date: segment.startDate)),
                        y: .value("Spending", segment.value)
                    )
                    .foregroundStyle(segment.color.gradient).cornerRadius(6)
                    .annotation(position: .top, alignment: .top) {
                        Text(CommonUtils.makeMoneyString(number: Int(segment.value)))
                            .fontWeight(.semibold)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(.quaternary.opacity(0.5), in: Capsule())
                            .background(in: Capsule())
                            .font(.caption)
                    }
                }
                
                
                
               
                
            }.frame(height: 260)
            //categorySelector
        }
        
    }
    
}

