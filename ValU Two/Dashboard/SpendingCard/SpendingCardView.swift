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
    
    init(budget : Budget, viewModel: SpendingCardViewModel){
        //print("Spending Card init")
        self.viewModel = viewModel
        self.budget = budget
        //viewModel.coordinator = coordinator
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

               // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
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
        GridItem(.flexible(), spacing: 13),
            GridItem(.flexible(), spacing: 13)
        ]
    
    

    
    var large : some View{
        VStack{
            
            Button(action: {
                // What to perform
                withAnimation{
                    self.isLarge.toggle()
                }
            }) {
                
                HStack{
                    SectionHeader(title: "Budgets", image: "creditcard")
                    Spacer()
                    
                    //if !isLarge{
                        Text(getRemainingDisplayText()).font(.system(size: 22, design: .rounded)).bold().lineLimit(1).padding(.trailing)
                    //}
                    
                    Image(systemName: "chevron.right").font(.system(size: 20)).foregroundColor(AppTheme().themeColorPrimary).rotationEffect(.degrees(isLarge ? 90 : 0))
                    
                }
            }.buttonStyle(PlainButtonStyle())
            
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
                                            self.viewModel.coordinator?.showIndvidualBudget(budgetSection: section)
                                        }) {
                                                ParentCategoryCard(budgetSection: section)
                                            }.buttonStyle(PlainButtonStyle())
                    

                        }
                }
                    
                    Button(action: {
                            // your action here
                        self.viewModel.coordinator?.showOtherTransactions(otherCardData: self.viewModel.otherCategory!)
                        }) {
                        ParentCategoryCard(color: AppTheme().otherColor, colorSecondary: AppTheme().otherColorSecondary, colorTertiary: AppTheme().otherColorTertiary, icon: "book", spent: self.viewModel.otherCategory!.spent, limit: self.viewModel.otherCategory!.limit, name: "Other", percentageSpent: Double(self.viewModel.otherCategory!.percentage))
                            }.buttonStyle(PlainButtonStyle())
                    
                    
                    
                }.padding(.top, 13)
            }
            
                
            
            
            
        }
    }
    
    var body: some View {
        
        large
        
        
    }
}




