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
            
            VStack(spacing: 1){
                
                Image(systemName: "creditcard.fill").font(.system(size: 90, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary).padding(.vertical)
                
                VStack(spacing: 5){
                    Text("Start Budgeting").font(.system(size: 30, design: .rounded)).fontWeight(.bold)
                    Text("Get started with your first budget").font(.system(size: 16, design: .rounded)).multilineTextAlignment(.center).foregroundColor(Color(.systemGray3))
                }.padding(.bottom, 10)
                
                
                
                
                Button(action: {
                    //Button Action
                    //self.coordinator.onboardingComplete()
                    self.coordinator.createNewBudget()
                    }){
                        HStack(spacing: 8){
                        Spacer()
                        Image(systemName: "plus.circle.fill").font(.system(size: 21, weight: .regular)).foregroundColor(Color(.white)).padding(.leading)
                            Text("Create Budget").font(.system(size: 18, design: .rounded)).foregroundColor(.white).bold().padding(.vertical).padding(.trailing)
                        
                        Spacer()
                        }.background(AppTheme().themeColorPrimary).cornerRadius(18).shadow(radius: 10).padding().padding(.bottom)
                    
                    
                }
            }.padding().cornerRadius(18).padding().padding(.bottom, 50)
            
            Spacer()
        }.navigationBarTitle("Summary")
    }
}


