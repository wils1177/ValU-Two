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
    
    
    
    
    var body: some View {
            
            
        VStack{
            ForEach(self.viewModel.services, id: \.self){ service in
                                      
                                  
                                      
                    VStack(spacing: 0){
                        if service.getParentLimit() > 0.0{
                                              
                            Button(action: {
                                    // your action here
                                    self.viewModel.coordinator?.showIndvidualBudget(budgetSection: service.parent)
                                }) {
                                        ParentCategoryCard(budgetSection: service.parent, service: service).padding(.bottom, 10)
                                    }.buttonStyle(PlainButtonStyle())
            
                                }
                                          

                }//.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                  
            }//.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
            
        
            
        
        
        /*
            
            Button(action: {
                // your action here
                self.viewModel.coordinator?.showOtherTransactions()
            }) {
                OtherSpendingSection(viewModel: self.viewModel).padding(.bottom)
            }.buttonStyle(PlainButtonStyle())
            
            */
                
                
            
            

            
            
            

        
        
    }
}




