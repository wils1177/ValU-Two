//
//  AccountsLoadedView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct AccountsLoadedView: View {
    
    var presentor : LoadingAccountsPresentor?
    var accounts : [AccountData]
    
    init(presentor: LoadingAccountsPresentor?){
        self.presentor = presentor
        self.accounts = presentor!.getLoadedAccounts()
    }
    
    var body: some View {
        
            VStack(alignment: .center){
                
               Spacer()
                
                Text("Accounts Successfully Loaded").font(.title).bold().lineLimit(nil).padding().multilineTextAlignment(.center).padding(.bottom, 55)
                
                LoadedAccountsList(accounts: self.accounts)
                Spacer()
                
                Button(action: {
                    //Button Action
                    self.presentor?.userPressedContinue()
                    }){
                    HStack{
                        Spacer()
                        ZStack{
                            Text("Continue").font(.subheadline).foregroundColor(.white).bold().padding()
                        }
                        Spacer()
                    }.background(AppTheme().themeColorPrimary).cornerRadius(10).shadow(radius: 10).padding(.horizontal).padding(.horizontal).padding(.bottom)
                    
                    
                }
                Button(action: {
                    //Button Action
                    self.presentor?.userSelectedAddMoreAccounts()
                    }){
                    HStack{
                        Spacer()
                        ZStack{
                            Text("Add More Accounts").font(.subheadline).foregroundColor(AppTheme().themeColorPrimary).bold().padding()
                        }
                        Spacer()
                    }.background(Color(red: 0.9, green: 0.9, blue: 0.9)).cornerRadius(10).shadow(radius: 0).padding(.horizontal).padding(.horizontal).padding(.bottom).padding(.bottom)
                    
                    
                }
                
                
        }
        
        
        .navigationBarTitle(Text("Welcome"),  displayMode: .large)
        .navigationBarHidden(true)
    }
}


