//
//  SwiftUIBudgetView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/13/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingCardView: View {
    
    var viewModel : SpendingCardViewModel
    @ObservedObject var budget : Budget
    
    @State var selectedSpendingState = 0
    
    var coordinator : BudgetsTabCoordinator?
    
    init(budget : Budget, budgetTransactionsService: BudgetTransactionsService, coordinator: BudgetsTabCoordinator? = nil){
        //print("Spending Card init")
        self.viewModel = SpendingCardViewModel(budget: budget, budgetTransactionsService: budgetTransactionsService)
        self.budget = budget
        self.coordinator = coordinator
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

               // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        print("spending card view created")
    }
    
    func getRemainingDisplayText() -> String {
        let remaining = self.viewModel.getRemainig()
        if remaining >= 0 {
            return CommonUtils.makeMoneyString(number: remaining) + " left"
        }
        else {
            return CommonUtils.makeMoneyString(number: remaining * -1) + " over"
        }
    }
    
    
    func getDisplayArray(categories: [BalanceParentService]) -> [[BalanceParentService]]{
        return categories.chunked(into: 2)
    }
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17)
        ]
    
    var menuItems: some View {
            Group {
                Button("Action 1", action: {})
                Button("Action 2", action: {})
                Button("Action 3", action: {})
            }
        }

    
    var large : some View{
            
        VStack{
            
            HStack{
                if self.selectedSpendingState == 0{
                    Text("Free Spending").font(.system(size: 23, design: .rounded)).fontWeight(.bold).listRowSeparator(.hidden)
                }
                else{
                    Text("Recurring").font(.system(size: 23, design: .rounded)).fontWeight(.bold).listRowSeparator(.hidden)
                }
                
                Spacer()
                
                Picker("", selection: $selectedSpendingState) {
                                Image(systemName: "play.fill").tag(0)
                                Image(systemName: "clock.arrow.circlepath").tag(1)
                                
                            }
                .pickerStyle(.segmented).frame(width: 105)
            }.padding(.bottom, 10).padding(.horizontal, 5)
            
            ForEach(self.budget.getBudgetSections(), id: \.self){ section in
                                      
                
                
                                              
                VStack(spacing: 0){
                    if self.selectedSpendingState == 0 && section.hasAnyFreeCategories(){
                        ParentCategoryCard(budgetSection: section, coordiantor: self.coordinator, selectedState: self.$selectedSpendingState).padding(.bottom, 20).padding(.horizontal, 2.5)
                    }
                    else if self.selectedSpendingState == 1 && section.hasAnyRecurringCategories(){
                        ParentCategoryCard(budgetSection: section, coordiantor: self.coordinator, selectedState: self.$selectedSpendingState).padding(.bottom, 20).padding(.horizontal, 2.5)
                    }
                }
                
                        
                

                    
                
                //Divider().padding(.bottom, 10)
            }
            
            if selectedSpendingState == 0{
                Button(action: {
                        // your action here
                    self.coordinator?.showListOfTransactions(title: "Other", list: self.viewModel.budgetTransactionsService.getOtherTransactionsInBudget())
                    }) {
                        OtherSectionView(service: self.viewModel.budgetTransactionsService)
                        
                            
                        
                        }.buttonStyle(PlainButtonStyle())
            }
            
        }
            
        
        
            
           
            
        
    }
    
    var body: some View {
        
        large//.padding().padding(.vertical, 5).background(Color(.tertiarySystemBackground)).cornerRadius(25)
        
        
    }
}




