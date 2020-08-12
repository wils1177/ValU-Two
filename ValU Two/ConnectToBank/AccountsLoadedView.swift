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
    
    var body: some View {
        
            VStack(alignment: .center){
                
                
                Text("Accounts Successfully Connected").font(.title).bold().lineLimit(nil).padding().multilineTextAlignment(.center).padding(.top).padding(.top)
                
                //LoadedAccountsList(accounts: self.accounts)
                //SnapCarousel(accounts: self.accounts).environmentObject(UIStateModel())
                if !self.cardsHidden{
                    CarouselView(itemHeight: 190, views: makeCardViews())
                }
                
                Spacer()
                
                Button(action: {
                    //Button Action
                    self.presentor?.userPressedContinue()
                    //self.cardsHidden = true
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


