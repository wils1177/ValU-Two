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
    
    init(budget: Budget, coordinator: SetSpendingLimitDelegate){
        
        self.viewModel = BudgetBalancerPresentor(budget: budget, coordinator: coordinator)
        

    }
    
    private var balancerBody: some View {
        BalancerBodyView(viewModel : self.viewModel)
    }
    

    
    var body: some View {
        
        
        
        self.balancerBody
            .navigationBarTitle("Set Budget", displayMode: .large).navigationBarItems(trailing:
                
                HStack{

                    Button(action: {
                        self.viewModel.coordinator?.finishedSettingLimits()
                    }){
                        
                        Text("Done")
                        
                    }
                }
            
            
            
            
            
        )
        
    }
    
  
}


