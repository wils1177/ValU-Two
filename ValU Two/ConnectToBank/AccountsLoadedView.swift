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
    
    @State var cardsHidden = false
    
    func makeCardViews() -> [AnyView]{
        var cards = [AnyView]()
        for account in self.accounts{
            cards.append(AnyView(SwiftUIAccountCardView(account: account)))
        }
        return cards
    }
    
    private var columns: [GridItem] = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16),
        ]
    
    var body: some View {
        
            VStack(alignment: .center){
                
                
                Text("Accounts Successfully Connected").font(.system(size: 32, design: .rounded)).fontWeight(.heavy).multilineTextAlignment(.center).padding(.top).padding(.top).padding(.horizontal, 10)
                
                
                
                
                
                ScrollView{
                    
                    

                    SwiftUIAccountsView(accounts: self.accounts).padding(.vertical)
                    
                }
                
                Spacer()
                
                VStack(spacing: 0){
                    Button(action: {
                        //Button Action
                        self.presentor?.userPressedContinue()
                        //self.cardsHidden = true
                        }){
                            ActionButtonLarge(text: "Done", color: globalAppTheme.themeColorPrimary.opacity(0.3), textColor: globalAppTheme.themeColorPrimary).padding(.horizontal).padding(.horizontal).padding(.bottom)
                        
                        
                    }
                    Button(action: {
                        //Button Action
                        self.presentor?.userSelectedAddMoreAccounts()
                        }){
                        
                            ActionButtonLarge(text: "Add More Accounts", color: Color(.lightGray).opacity(0.25), textColor: globalAppTheme.themeColorPrimary).padding(.horizontal).padding(.horizontal)
                        
                        
                    }
                }.padding(.top).padding(.bottom, 10)
                
     
                }

        
        .navigationBarTitle(Text("Welcome"),  displayMode: .large)
        .navigationBarHidden(true)
    }
}


