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
    
    init(coordinator: BudgetsTabCoordinator){
        self.coordinator = coordinator
        let fontSize: CGFloat = 35

        // Here we get San Francisco with the desired weight
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)

        // Will be SF Compact or standard SF in case of failure.
        let font: UIFont

        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: fontSize)
        } else {
            font = systemFont
        }
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
    }
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            
                VStack(alignment: .center, spacing: 10){
                    Image(systemName: "mail.and.text.magnifyingglass")
                        .font(.system(size: 95))
                        .font(.largeTitle.weight(.heavy))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(globalAppTheme.themeColorPrimary).padding(.bottom)
                    Text("Start Budgeting").font(.system(size: 30, weight: .heavy, design: .rounded)).multilineTextAlignment(.center)
                    Text("Start here to setup your very first budget. This is how you can track your spending!").font(.system(size: 18, weight: .semibold, design: .rounded)).foregroundColor(Color(.lightGray)).multilineTextAlignment(.center).padding(.top, 10)
                
                
                
            }.padding(.bottom, 50).padding(.horizontal, 25)
            
            
                Button(action: {
                    //Button Action
                    //self.coordinator.onboardingComplete()
                    self.coordinator.createNewBudget()
                    }){
                        
                        
                        ActionButtonLarge(text: "Create Budget", color: globalAppTheme.themeColorPrimary.opacity(0.25), textColor: globalAppTheme.themeColorPrimary).padding(.horizontal).padding(.horizontal)
                    
                    
                }
            
            
            Spacer()
        }.navigationBarTitle("Budget")
    }
}


