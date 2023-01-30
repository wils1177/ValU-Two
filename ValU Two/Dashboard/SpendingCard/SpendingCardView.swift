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
    
    @Binding var budgetFilter: BudgetFilter
    
    var coordinator : BudgetsTabCoordinator?
    
    init(budget : Budget, budgetTransactionsService: BudgetTransactionsService, coordinator: BudgetsTabCoordinator? = nil, budgetFilter: Binding<BudgetFilter>){
        //print("Spending Card init")
        self.viewModel = SpendingCardViewModel(budget: budget, budgetTransactionsService: budgetTransactionsService)
        self.budget = budget
        self.coordinator = coordinator
        self._budgetFilter = budgetFilter
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
    
    
    var recurringZeroState: some View{
        VStack{
            Image(systemName: "clock.arrow.circlepath").font(.system(size: 65)).font(.largeTitle.weight(.heavy)).symbolRenderingMode(.hierarchical).padding(.trailing, 10).foregroundColor(AppTheme().themeColorPrimary)
            Text("No Recurring Categories Yet").font(.system(size: 20, weight: .bold, design: .rounded)).multilineTextAlignment(.center).padding(.top)
            Text("Recurring categories are those that repeat every month (Rent, Subscriptsions, etc). Budget App can assume that within your budget, you've already spent these. To create one, simple mark one of your existing categories as reuccing in the edit screen.").font(.system(size: 16, weight: .semibold, design: .rounded)).foregroundColor(Color.gray).multilineTextAlignment(.center).padding(.top, 3)
        }.padding(.horizontal).background(Color(.systemBackground)).cornerRadius(23).padding(.bottom).padding(.bottom)
    }

    @ViewBuilder
    var large : some View{
            
            
            
            
            
            if budgetFilter == .Recurring && self.viewModel.budgetTransactionsService.getRecurringBudgetCategories().count == 0{
                
                self.recurringZeroState
            }
        
        if budgetFilter == .Spending || budgetFilter == .Recurring{
            
            HStack{
                Text("Categories").font(.system(size: 24, weight: .bold, design: .rounded))
                Spacer()
            }.padding([.horizontal], 16)
            
        }
        
            
            ForEach(self.budget.getBudgetSections(), id: \.self){ section in
                                      
                
                    if self.budgetFilter == .Spending && section.hasAnyFreeCategories(){
                        
                        VStack(spacing: 0){
                            
                            ParentCategoryCard(budgetSection: section, coordiantor: self.coordinator, budgetFilter: self.$budgetFilter)
                        }.padding(10).background(Color(.tertiarySystemBackground)).cornerRadius(12).padding([.horizontal, .bottom], 16)
                        
                        
                            
                        
                            
                        }
                    else if self.budgetFilter == .Recurring && section.hasAnyRecurringCategories(){
                        
                        VStack(spacing: 0){
                            
                            ParentCategoryCard(budgetSection: section, coordiantor: self.coordinator, budgetFilter: self.$budgetFilter)
                        }.padding(10).background(Color(.tertiarySystemBackground)).cornerRadius(12).padding([.horizontal, .bottom], 16)
                           
                        }
                
                
                
                      
                
                
            }
            
        /*
            if budgetFilter == .Spending{
                Button(action: {
                        // your action here
                    self.coordinator?.showListOfTransactions(title: "Other", list: self.viewModel.budgetTransactionsService.getOtherTransactionsInBudget())
                    }) {
                        OtherSectionView(service: self.viewModel.budgetTransactionsService)
                        
                            
                        
                        }.buttonStyle(PlainButtonStyle())
            }
          */
        
            
        
        
            
           
            
        
    }
    
    var body: some View {
        
        large
        
        
    }
}




