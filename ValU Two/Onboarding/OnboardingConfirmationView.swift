//
//  OnboardingConfirmationView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct OnboardingConfirmationView: View {
    
    var coordinator: OnboardingFlowCoordinator
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            Image(systemName: "checkmark.seal.fill").font(.system(size: 100, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary).padding(.bottom).padding(.bottom)
            Text("You are all set to start using ValU Two!").font(.headline).fontWeight(.semibold)
            Spacer()
            
            Button(action: {
                //Button Action
                self.coordinator.onboardingComplete()
                }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Onward!").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    Spacer()
                }.background(AppTheme().themeColorPrimary).cornerRadius(10).shadow(radius: 10).padding().padding(.horizontal).padding(.bottom)
                
                
            }
        }
    }
}

