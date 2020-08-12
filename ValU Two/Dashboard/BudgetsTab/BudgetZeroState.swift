//
//  BudgetZeroState.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetZeroState: View {
    
    var coordinator: BudgetsTabCoordinator
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            Image(systemName: "creditcard.fill").font(.system(size: 100, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary).padding(.bottom)
            Text("You don't have a budget set up yet. Tap to get started!").font(.headline).fontWeight(.regular).multilineTextAlignment(.center).padding().padding(.bottom)
            
            
            Button(action: {
                //Button Action
                //self.coordinator.onboardingComplete()
                self.coordinator.createNewBudget()
                }){
                    HStack(spacing: 8){
                    Spacer()
                    Image(systemName: "plus.circle.fill").font(.system(size: 19, weight: .regular)).foregroundColor(Color(.white)).padding(.leading)
                        Text("Create Budget").font(.subheadline).foregroundColor(.white).bold().padding(.vertical).padding(.trailing)
                    
                    Spacer()
                }.background(AppTheme().themeColorPrimary).cornerRadius(10).shadow(radius: 10).padding().padding(.horizontal).padding(.bottom)
                
                
            }
            Spacer()
        }.navigationBarTitle("Budget")
    }
}


