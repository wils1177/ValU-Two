//
//  WelcomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI
import AuthenticationServices


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
            
            Text("test status").onTapGesture {
                Task {
                        do {
                            await UserManager().checkiCloudStatus()
                        } 
                     }
                
                
                
            }
            
            SignInWithAppleButton(.continue) { request in
                request.requestedScopes = nil
                
                } onCompletion: { result in
                  switch result {
                    case .success(let authResults):
                      print("Authorisation successful")
                      
                      switch authResults.credential{
                      case let credential as ASAuthorizationAppleIDCredential:
                          
                          let userId = credential.user
                          print(userId)
                          
                          
                          
                          
                      default:
                          break
                      }
                      
                    case .failure(let error):
                      print("Authorisation failed: \(error.localizedDescription)")
                  }
                }
                // black button
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .padding()
            
            
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
