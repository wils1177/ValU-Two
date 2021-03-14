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
                
                
                Text("Accounts Successfully Connected").font(.title).bold().lineLimit(nil).padding().multilineTextAlignment(.center).padding(.top).padding(.top)
                
                
                if !self.cardsHidden{
                    CarouselView(itemHeight: 190, views: makeCardViews())
                }
                
                /*
                ScrollView{
                    LazyVGrid(
                                    columns: columns,
                                    alignment: .center,
                                    spacing: 16,
                                    pinnedViews: [.sectionHeaders, .sectionFooters]
                                )
                    {
                        ForEach(self.accounts, id: \.self) { account in
                            SwiftUIAccountCardView(account: account, isSmall: true)
                                }
                    }.padding(5)
                }
                */
                Spacer()
                
                VStack(spacing: 0){
                    Button(action: {
                        //Button Action
                        self.presentor?.userPressedContinue()
                        //self.cardsHidden = true
                        }){
                        ActionButtonLarge(text: "Done")
                        
                        
                    }
                    Button(action: {
                        //Button Action
                        self.presentor?.userSelectedAddMoreAccounts()
                        }){
                        HStack{
                            Spacer()
                            ZStack{
                                Text("Add More Accounts").font(.headline).foregroundColor(AppTheme().themeColorPrimary).bold().padding()
                            }
                            Spacer()
                        }.background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20).shadow(radius: 0).padding(.horizontal).padding(.horizontal).padding(.bottom).padding(.bottom)
                        
                        
                    }
                }
                
     
                }

        
        .navigationBarTitle(Text("Welcome"),  displayMode: .large)
        .navigationBarHidden(true)
    }
}


