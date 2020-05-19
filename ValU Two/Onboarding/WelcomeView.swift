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
            
           Spacer()
            
            Text("Welcome to").font(.largeTitle).bold()
            Text("Budget App 69 ").font(.largeTitle).bold().foregroundColor(AppTheme().themeColorPrimary).padding(.bottom).padding(.bottom)
            
            MarketingRow(imageName: "creditcard", headline: "Budget", description: "Set goals and track your spending over time.").padding(.horizontal).padding(.leading).padding(.bottom, 10)
            MarketingRow(imageName: "arrow.clockwise.circle", headline: "Automated", description: "Connect to your bank and never worry about manually entering your spending.").padding(.horizontal).padding(.leading).padding(.bottom, 10)
            MarketingRow(imageName: "lock.circle", headline: "Private", description: "Your financial date stays on your device").padding(.horizontal).padding(.leading).padding(.bottom, 10)


            Spacer()
            Button(action: {
                //Button Action
                self.coordinator?.continueToOnboarding()
                }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Get Started").font(.subheadline).foregroundColor(Color(.systemBackground)).bold().padding()
                    }
                    Spacer()
                }.background(AppTheme().themeColorPrimary).cornerRadius(10).shadow(radius: 10).padding().padding(.horizontal).padding(.bottom)
                
                
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
