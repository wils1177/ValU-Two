//
//  AddFutureBudgetButton.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct AddFutureBudgetButton: View {
    
    var viewModel : BudgetsTabViewModel
    var isSmall : Bool
    
    @State var showActionSheet: Bool = false
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Create an upcomming budget"), message: Text("Choose An Option"), buttons: [
            .default(Text("Start with Existing Budget")){self.viewModel.userSelectedCreateFromExistinBudget()},
            .default(Text("Start from Scratch")){self.viewModel.userSelectedCreateNewBudgetFromScratch()},
            .destructive(Text("Cancel"))
        ])
    }
    
    var body: some View {
        Button(action: {
            //action
            self.showActionSheet.toggle()
        }){
            Image(systemName: "plus.circle.fill").imageScale(.large)
            if !self.isSmall{
                Text("New Budget").fontWeight(.bold)
            }
            
        }.buttonStyle(BorderlessButtonStyle())
            .actionSheet(isPresented: $showActionSheet, content: {
        self.actionSheet })
    }
}


