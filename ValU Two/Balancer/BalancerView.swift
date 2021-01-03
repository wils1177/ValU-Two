//
//  BalancerView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/28/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BalancerView: View {
    
    @ObservedObject var viewModel : BudgetBalancerPresentor
    @State private var bottomSheetShown = false
    var budget : Budget
    
    init(budget: Budget, coordinator: SetSpendingLimitDelegate){
        self.budget = budget
        self.viewModel = BudgetBalancerPresentor(budget: budget, coordinator: coordinator)
        
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        
        

    }
    
    private var balancerBody: some View {
        BalancerBodyView(viewModel : self.viewModel, budget: self.budget)
    }
    

    
    var body: some View {
        
        
        
        self.balancerBody
            .navigationBarTitle("Set Budgets", displayMode: .large).navigationBarItems(trailing:
                
                HStack{
                    
                    

                    Button(action: {
                        self.viewModel.coordinator?.finishedSettingLimits()
                    }){
                        
                        ColoredActionButton(text: "Finish")
                        
                    }
                }
            
            
            
            
            
        )
        
    }
    
  
}


