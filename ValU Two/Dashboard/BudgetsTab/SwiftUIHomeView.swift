//
//  SwiftUIHomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI
import SwiftKeychainWrapper

enum BudgetFilter{
    case Spending
    case Recurring
    case Income
    case All
}

struct BudgetsView: View {
    
    @ObservedObject var viewModel: BudgetsViewModel
    @ObservedObject var budget: Budget
    @ObservedObject var fixNowService : FixNowService
    
    @State var budgetFilter: BudgetFilter = .Spending

    
    init(viewModel: BudgetsViewModel, budget: Budget){
        self.viewModel = viewModel
        self.budget = budget
        self.fixNowService = FixNowService(coordinator: viewModel.coordinator!)
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        let fontSize: CGFloat = 35

        // Here we get San Francisco with the desired weight
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)

        // Will be SF Compact or standard SF in case of failure.
        let font: UIFont

        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: fontSize)
        } else {
            font = systemFont
        }
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
        
        /*
        UINavigationBar.appearance().barTintColor = globalAppTheme.backgroundColorUIKit
        UINavigationBar.appearance().backgroundColor =  globalAppTheme.backgroundColorUIKit
        
        UITabBar.appearance().backgroundColor = globalAppTheme.backgroundColorUIKit
        
        UITabBar.appearance().barTintColor = globalAppTheme.backgroundColorUIKit
        */
        print("home init")
    }
    
    func getTitle() -> String{
        let monthInt = Calendar.current.component(.month, from: Date()) // 4
        let monthStr = Calendar.current.monthSymbols[monthInt-1]  // April
        
        let dayInt = Calendar.current.component(.day, from: Date()) // 4
        let dayStr = String(dayInt)  // April
        
        return monthStr
        
    }
    
    var fixNowCards: some View{
        
        ForEach(self.fixNowService.exiredItemIds, id: \.self){ expiredId in
            FixNowCard(service: self.fixNowService, itemId: expiredId).listRowBackground(Color(.clear)).listRowSeparator(.hidden)
        }
    }
    

    
    var summary: some View{
        HStack(alignment: .top){
            
            VStack(alignment: .leading){
                
                
                if self.budgetFilter == .Spending{
                    
                    
                        
                        
                        HStack{
                            //Image(systemName: "creditcard.fill").font(.system(size: 18, design: .rounded)).foregroundColor(Color(.lightGray))
                            Text("Left in Budget").font(.system(size: 16, design: .rounded)).bold().foregroundColor(Color(.lightGray))
                        }
                    Text("\(CommonUtils.makeMoneyString(number:(Int(self.viewModel.budgetTransactionsService.getLeftInBudget()))))").font(.system(size: 31, design: .rounded)).fontWeight(.heavy).foregroundColor(globalAppTheme.themeColorPrimary)
                        
                        
                    
                    
                    
                    //Text("Left in budget").foregroundColor(Color(.lightGray)).font(.system(size: 20, weight: .bold, design: .rounded))
                    //Text("\(CommonUtils.makeMoneyString(number:(Int(self.viewModel.budgetTransactionsService.getLeftInBudget()))))").font(.system(size: 37, weight: .heavy, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                    
                }
                else if self.budgetFilter == .Income{
                    HStack{
                        //Image(systemName: "creditcard.fill").font(.system(size: 18, design: .rounded)).foregroundColor(Color(.lightGray))
                        Text("Income").font(.system(size: 16, design: .rounded)).bold().foregroundColor(Color(.lightGray))
                    }
                    Text("\(CommonUtils.makeMoneyString(number:(Int(self.viewModel.budgetTransactionsService.getBudgetIncome() * -1))))").font(.system(size: 30, weight: .heavy, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                    
                }
                else if self.budgetFilter == .Recurring{
                    HStack{
                        //Image(systemName: "creditcard.fill").font(.system(size: 18, design: .rounded)).foregroundColor(Color(.lightGray))
                        Text("Recurring Reimaining").font(.system(size: 16, design: .rounded)).bold().foregroundColor(Color(.lightGray))
                    }
                    Text("\(CommonUtils.makeMoneyString(number:(Int(self.viewModel.budgetTransactionsService.getLeftRecurring()))))").font(.system(size: 30, weight: .heavy, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                    
                }
                
                
                
  
                
            }
            Spacer()
            
            
            Menu() {
                
                
                Picker(selection: $budgetFilter, label: Text("Budget Section")) {
                    
                    Label("Spending", systemImage: "chart.bar.doc.horizontal").tag(BudgetFilter.Spending)
                    Label("Recurring", systemImage: "chart.line.uptrend.xyaxis.circle").tag(BudgetFilter.Recurring)
                    //  Label("All Spending", systemImage: "chart.line.uptrend.xyaxis.circle").tag(2)
                    Label("Income", systemImage: "chart.line.uptrend.xyaxis").tag(BudgetFilter.Income)
                    
                    
                    
                }
                
            }
            label: {
                
                HStack(spacing: 3){
                    
                    if self.budgetFilter == .Spending{
                        Image(systemName: "chart.bar.doc.horizontal").font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                        Text("Spending").font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                    }
                    else if self.budgetFilter == .Income{
                        Image(systemName: "chart.line.uptrend.xyaxis").font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                        Text("Income").font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                    }
                    else if self.budgetFilter == .Recurring{
                        Image(systemName: "chart.line.uptrend.xyaxis.circle").font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                        Text("Recurring").font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                    }
                    
                        
                        Image(systemName: "chevron.down").font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                    
                    
                }.padding(.horizontal, 12).padding(.vertical, 6).background(Color(.tertiarySystemBackground)).clipShape(Capsule())
                
            }
            
           
        }
    }
    

    

    
    var body: some View {
        
            ScrollView{
                
                    if self.fixNowService.exiredItemIds.count > 0{
                        fixNowCards
                    }
                        
     
                
                    
                self.summary.padding(.horizontal, 16).padding(.top, 16)
                
                        
                                    
                VStack(alignment: .leading, spacing: 6){
                    
                    Text("This Month vs Last Month").font(.system(size: 21, weight: .bold, design: .rounded)).padding(.leading, 5).padding(.bottom, 5)
                    //summary.padding(.horizontal, 8).padding(.bottom, 8)
                    ThisMonthLastMonthGraph(budget: self.budget
                                            , budgetTransactionsService: self.viewModel.budgetTransactionsService, budgetFilter: self.$budgetFilter).listRowSeparator(.hidden)
                }.padding(10).background(Color(.tertiarySystemBackground)).cornerRadius(12).padding([.horizontal, .bottom], 16)
                
                
                
                
                
                    
                
                
                SpendingCardView(budget: self.viewModel.currentBudget, budgetTransactionsService: self.viewModel.budgetTransactionsService, coordinator: self.viewModel.coordinator, budgetFilter: self.$budgetFilter).listRowSeparator(.hidden)
               
                
                
            }
            .background(Color(uiColor: .systemGroupedBackground))
           
            
            .refreshable {
                let refreshModel = OnDemandRefreshViewModel()
                await refreshModel.refreshAllItems()
            }
        
        
 
        
            
                  
            .navigationBarTitle(self.getTitle()).navigationBarItems(
            
            leading: Button(action: {
                self.viewModel.coordinator!.editClicked(budgetToEdit: self.viewModel.currentBudget)
            }){
                NavigationBarTextButton(text: "Edit")
                }
                                                                   
                                                                   
                , trailing: Button(action: {
                    self.viewModel.clickedSettingsButton()
                }){
                
                    CircleButtonIcon(icon: "gear", color: AppTheme().themeColorPrimary)
        })
           
        
        
    }
}
/*
struct SwiftUIHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIHomeView()
    }
}
*/
