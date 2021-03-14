//
//  BudgetConfirmationView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/13/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetConfirmationView: View {
    
    var coordinator: NewBudgetCoordinator
    
    init(coordinator: NewBudgetCoordinator){
        self.coordinator = coordinator
    }
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.navigationBarTitle("", displayMode: .large).navigationBarItems(trailing:
                                                                                        
        HStack{

            Button(action: {
                self.coordinator.finishSettingUpBudget()
            }){
                
                NavigationBarTextButton(text: "Finish")
                
            }
        })
        
    }
}


