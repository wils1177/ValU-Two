//
//  WelcomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    
    var coordinator : OnboardingFlowCoordinator?
    
    var body: some View {
        
        VStack(){
            
            
            HStack{
                VStack(alignment: .leading, spacing: 0){
                    Text("🎉").font(.system(size: 50))
                    Text("Welcome to").font(.system(size: 42, design: .rounded)).fontWeight(.heavy)
                    Text("Budget App  ").font(.system(size: 42, design: .rounded)).fontWeight(.heavy).foregroundColor(AppTheme().themeColorPrimary).padding(.bottom, 5)
                    Text("An average budgeting app at best.").foregroundColor(Color(.gray)).bold()
                }
                
                Spacer()
            }.padding(.leading).padding(.bottom).padding(.bottom).padding(.top, 80)
            
            
            MarketingRow(imageName: "💰", headline: "Budget", description: "Set goals and track your spending over time.").padding(.horizontal).padding(.leading).padding(.bottom, 10)
            MarketingRow(imageName: "🌀", headline: "Automated", description: "Connect to your bank and never worry about manually entering your spending.").padding(.horizontal).padding(.leading).padding(.bottom, 10)
            MarketingRow(imageName: "🔐", headline: "Private", description: "Your financial data stays on your device.").padding(.horizontal).padding(.leading).padding(.bottom, 10)


            Spacer()
            Button(action: {
                //Button Action
                self.coordinator?.continueToOnboarding()
                }){
                ActionButtonLarge(text: "Get Started")
                
                
            }
            
            
        }.navigationBarTitle(Text("Welcome"),  displayMode: .large)
        .navigationBarHidden(true)
        
        

        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
