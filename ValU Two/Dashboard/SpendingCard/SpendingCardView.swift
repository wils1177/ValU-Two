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
    var budget : Budget
    
    init(budget : Budget, viewModel: SpendingCardViewModel, coordinator: BudgetsTabCoordinator){
        //print("Spending Card init")
        self.viewModel = viewModel
        self.budget = budget
        viewModel.coordinator = coordinator
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

               // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
    }
    
    
    func getDisplayArray(categories: [BalanceParentService]) -> [[BalanceParentService]]{
        return categories.chunked(into: 2)
    }
    
    private var columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        
        LazyVGrid(      columns: columns,
                        alignment: .center,
                        spacing: 16,
                        pinnedViews: [.sectionHeaders, .sectionFooters]
        ){
            ForEach(self.viewModel.services, id: \.self){ service in
                                      
                                  
                                      
                    VStack(spacing: 0){
                        if service.getParentLimit() > 0.0{
                                              
                            Button(action: {
                                    // your action here
                                    self.viewModel.coordinator?.showIndvidualBudget(budgetSection: service.parent)
                                }) {
                                        ParentCategoryCard(budgetSection: service.parent)
                                    }.buttonStyle(PlainButtonStyle())
            
                                }
                                          

                }
        }
        }
        
        
        
            
        
        
        
            
            
            
            
                
                
            
            

            
            
            

        
        
    }
}




