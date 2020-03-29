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
    
    init(viewModel: BudgetBalancerPresentor){
        
        self.viewModel = viewModel
        

    }
    
    private var balancerBody: some View {
        BalancerBodyView(viewModel : self.viewModel)
    }
    

    
    var body: some View {
        
        
        
        self.balancerBody
            .navigationBarTitle("Balance Budget", displayMode: .large).navigationBarItems(trailing:
                
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


