//
//  PastBudgetsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/8/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct PastBudgetsView: View {
    
    @ObservedObject var viewModel : HistoryViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    init(viewModel: HistoryViewModel){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        
        //UITableViewCell.appearance().backgroundColor = .clear
        //UITableView.appearance().backgroundColor = .clear
    }
    
    var historyZeroState : some View{
        VStack{
            Image(systemName: "books.vertical.circle").font(.system(size: 65)).font(.largeTitle.weight(.heavy)).symbolRenderingMode(.hierarchical).padding(.trailing, 10).foregroundColor(AppTheme().themeColorPrimary).padding(.top)
            Text("No Compelted Budgets Yet").font(.system(size: 20, weight: .bold, design: .rounded)).multilineTextAlignment(.center).padding(.top)
            Text("Past budgets will show up here when completed").font(.system(size: 16, weight: .semibold, design: .rounded)).foregroundColor(Color.gray).multilineTextAlignment(.center).padding(.top, 3)
        }.padding(.bottom).padding(.bottom)
    }
    
    var header : some View{
        HStack{
            Text("Past Budgets").font(.system(size: 15, design: .rounded)).fontWeight(.bold).listRowSeparator(.hidden)
            Spacer()
        }
    }
    
    func getBudgetName(budget: Budget) -> String{
        let monthInt = Calendar.current.component(.month, from: budget.startDate!) // 4
        let monthStr = Calendar.current.monthSymbols[monthInt-1]  // April
        
        let dayInt = Calendar.current.component(.day, from: budget.startDate!) // 4
        let dayStr = String(dayInt)  // April
        
        return monthStr
        
    }
    
    var body: some View {
        Section(header: header){
                
                if self.viewModel.historicalBudgets.count > 0 {
                    ForEach(viewModel.historicalBudgets, id: \.self) { budget in
                            

                        Button(action: {
                            self.viewModel.coordinator?.showBudgetDetail(budget: budget, service: self.viewModel.service, title: self.getBudgetName(budget: budget))
                            
                        }) {
                            HStack{
                                Text(self.getBudgetName(budget: budget)).font(.system(size: 18, design: .rounded)).fontWeight(.semibold).foregroundColor((colorScheme == .dark) ? Color.white : Color.black)
                                Spacer()
                                
                                Text(CommonUtils.makeMoneyString(number: Int(self.viewModel.service.getAmountSavedForBudget(budget: budget)) ) + " Saved").font(.system(size: 18, design: .rounded)).fontWeight(.semibold).foregroundColor(Color(.systemGreen))
                            }
                        }
                        
                        
                        
                        
                        
                    }
                }
                else{
                    HStack{
                        Spacer()
                        historyZeroState.padding(.top)
                        Spacer()
                    }
                    
                }
                
                
            }
            
        
    }
}


