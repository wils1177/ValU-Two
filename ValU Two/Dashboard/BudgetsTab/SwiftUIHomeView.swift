//
//  SwiftUIHomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI
import SwiftKeychainWrapper

struct BudgetsView: View {
    
    @ObservedObject var viewModel: BudgetsViewModel
    @ObservedObject var budget: Budget
    @ObservedObject var fixNowService : FixNowService

    
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
            FixNowCard(service: self.fixNowService, itemId: expiredId).padding(.horizontal)
        }
    }
    

    
    
    

    

    
    var body: some View {
        
            List{
                
                    if self.fixNowService.exiredItemIds.count > 0{
                        fixNowCards
                    }
                        
                
                        
                //TimeSectionView(budget: self.viewModel.currentBudget, service: self.viewModel.budgetTransactionsService, coordinator: self.viewModel.coordinator).padding(.horizontal, 25).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowSeparator(.hidden).padding(.top, 10)
                        
                            
                            
                            //self.topButtons//.padding(.top, 7)
                            
                        //Divider()
                        
                                    
                                    //self.budgetHeader.padding(.bottom,5)
                BudgetCardView(budget: self.budget, viewModel: self.viewModel).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    
                                    
                                    
                                   
                                    
                                
                        
                        //Divider()
                        
                        
                        

                        
                    //IncomeSectionView(coordinator: self.viewModel.coordinator, service: self.viewModel.budgetTransactionsService, budget: self.budget).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowBackground(Color.clear).listRowSeparator(.hidden).padding(.horizontal)
                
                        
                        
                       // Divider()

                
                
                Section(){
                    Text("Spending Breakdown").font(.system(size: 23, design: .rounded)).fontWeight(.bold).listRowSeparator(.hidden)
                    //BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData(), showLegend: false).listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).padding(.horizontal, 30)
                    SpendingCardView(budget: self.viewModel.currentBudget, budgetTransactionsService: self.viewModel.budgetTransactionsService, coordinator: self.viewModel.coordinator).listRowSeparator(.hidden)
                }.listRowBackground(Color.clear)
                
                
            }
            .listStyle(PlainListStyle())
            .background(Color(.white))
            .refreshable {
                print("try refreshing")
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
