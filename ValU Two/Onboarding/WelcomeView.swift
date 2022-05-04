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
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 11),
            GridItem(.flexible(), spacing: 11),
        GridItem(.flexible(), spacing: 11),
        GridItem(.flexible(), spacing: 11)
        ]
    
    var body: some View {
        
        VStack(){
            
            Spacer()
            
            
            
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    
                    
                    
                    
                    Image(systemName: "mail.stack")
                        .font(.system(size: 80))
                        .font(.largeTitle.weight(.heavy))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(Color(.white)).padding(.bottom, 10)
                    
                    
                    Text("Welcome to Budget App").font(.system(size: 33, design: .rounded)).fontWeight(.heavy).foregroundColor(Color(.white))
                    Text("An app to help you budget and save for the future").foregroundColor(Color(.white)).bold().padding(.top, 10)
                }
                
                Spacer()
            }.padding(.leading).padding(.bottom, 50).padding(.horizontal, 10)
            
            
            
                
            
            
            
          

            Spacer()
            Button(action: {
                //Button Action
                self.coordinator?.continueFromWelcome()
                }){
                    ActionButtonLarge(text: "Get Started", color: Color(.white), textColor: globalAppTheme.themeColorPrimary).padding().padding(.horizontal)
                
                
            }
            
            
        }
        .background(globalAppTheme.themeColorPrimary)
        .navigationBarTitle(Text("Welcome"),  displayMode: .large)
        .navigationBarHidden(true)
        
        

        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
