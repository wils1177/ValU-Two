//
//  AddFutureBudgetButton.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct AddFutureBudgetButton: View {
    
    var viewModel : BudgetsViewModel
    var isSmall : Bool
    
    
    
    var body: some View {
        Button(action: {
            //action
            //self.viewModel.userSelectedToCreateNewBudget()
        }){
            Image(systemName: "plus.circle.fill").imageScale(.large)
            if !self.isSmall{
                Text("New Budget").fontWeight(.bold)
            }
            
        }.buttonStyle(BorderlessButtonStyle())
            
    }
}


