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
    
    @State var isLarge : Bool = true
    
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
            
            
            ForEach(self.budget.getBudgetSections(), id: \.self){ section in
                                      
                                  
                                      
                    VStack(spacing: 0){
                                              
                            Button(action: {
                                    // your action here
                                    self.coordinator?.showIndvidualBudget(budgetSection: section)
                                }) {
                                    ParentCategoryCard(budgetSection: section)
                                        
                                    }.buttonStyle(PlainButtonStyle())
                        
                        

                    }.padding(.bottom, 10)
                
                //Divider().padding(.bottom, 10)
            }
            
            
            /*
            if isLarge{
                
                LazyVGrid(      columns: columns,
                                alignment: .center,
                                spacing: 15,
                                pinnedViews: [.sectionHeaders, .sectionFooters]
                ){
                    ForEach(self.budget.getBudgetSections(), id: \.self){ section in
                                              
                                          
                                              
                            VStack(spacing: 0){
                                                      
                                    Button(action: {
                                            // your action here
                                            self.coordinator?.showIndvidualBudget(budgetSection: section)
                                        }) {
                                            ParentCategoryCard(budgetSection: section)//.shadow(radius: 7)
                                                
                                            }.buttonStyle(PlainButtonStyle())
                    

                        }
                }
                    
                    
                    Button(action: {
                            // your action here
                        self.coordinator?.showOtherTransactions(otherCardData: self.viewModel.otherCategory!)
                        }) {
                        ParentCategoryCard(color: AppTheme().otherColor, colorSecondary: AppTheme().otherColorSecondary, colorTertiary: AppTheme().otherColorTertiary, icon: "book", spent: self.viewModel.otherCategory!.spent, limit: self.viewModel.otherCategory!.limit, name: "Other", percentageSpent: Double(self.viewModel.otherCategory!.percentage))//.shadow(radius: 7)
                            
                                
                            
                            }.buttonStyle(PlainButtonStyle())
                    
                        
                    
                    
                }
            }
            
               
            
            */
            
        }
    }
    
    var body: some View {
        
        large//.padding().padding(.vertical, 5).background(Color(.tertiarySystemBackground)).cornerRadius(25)
        
        
    }
}




