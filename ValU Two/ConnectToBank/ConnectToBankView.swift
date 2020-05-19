//
//  ConnectToBankView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ConnectToBankView: View {
    
    var coordinator : OnboardingFlowCoordinator?
    
    
    var body: some View {
        
        VStack(alignment: .center){
            
           Spacer()
            
            Text("To use budgetpoop12$13, connect to your bank!").font(.title).bold().lineLimit(nil).padding().multilineTextAlignment(.center).padding(.bottom, 70)
            
            Spacer()
            Button(action: {
                //Button Action
                self.coordinator?.launchPlaidLink()
                }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Sure, dude!").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    Spacer()
                }.background(AppTheme().themeColorPrimary).cornerRadius(10).shadow(radius: 10).padding().padding(.horizontal).padding(.bottom)
                
                
            }
            
            
        }.navigationBarHidden(true)
    }
}

struct ConnectToBankView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectToBankView()
    }
}
