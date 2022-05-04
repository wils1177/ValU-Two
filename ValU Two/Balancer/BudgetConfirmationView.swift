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
            Spacer()
            VStack(alignment: .center){
                Text("🎉").font(.system(size: 90, design: .rounded)).fontWeight(.heavy).foregroundColor(Color(.white)).padding(.bottom)
                
                Text("You've made your first budget!").font(.system(size: 32, design: .rounded)).fontWeight(.heavy).multilineTextAlignment(.center).foregroundColor(Color(.white))
                
                Text("Now, we'll help you automatically track your spending against your goals. You can edit these any time").font(.system(size: 20, design: .rounded)).fontWeight(.semibold).foregroundColor(Color(.white)).multilineTextAlignment(.center).padding(.top)
                
                
            }.padding(.horizontal).padding(.bottom, 80)
            Spacer()
            
            Button(action: {
                //Button Action
                self.coordinator.finishSettingUpBudget()
                }){
                    ActionButtonLarge(text: "All Done!", color: Color(.white), textColor: globalAppTheme.themeColorPrimary).padding(.horizontal).padding(.horizontal).padding(.bottom)
                
                
            }
            
            Button(action: {
                //Button Action
                self.coordinator.goBack()
                }){
                    ActionButtonLarge(text: "Edit More...", color: Color(.white), textColor: globalAppTheme.themeColorPrimary).padding(.horizontal).padding(.horizontal)
                
                
                }.padding(.bottom)
            
        }
        .background(globalAppTheme.themeColorPrimary)
        .navigationBarTitle("", displayMode: .large)
        .navigationBarItems(trailing:
                                                                                        
        HStack{

            Button(action: {
                self.coordinator.finishSettingUpBudget()
            }){
                
                NavigationBarTextButton(text: "Finish")
                
            }
        })
        
    }
}


