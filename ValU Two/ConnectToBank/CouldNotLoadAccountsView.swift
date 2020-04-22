//
//  CouldNotLoadAccountsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CouldNotLoadAccountsView: View {
    
    var presentor : LoadingAccountsPresentor?
    
    init(presentor: LoadingAccountsPresentor?){
        self.presentor = presentor
    }
    
    var body: some View {
        VStack{
            CouldNotLoadView(errorMessage: "Could Not Load Accounts")
            Spacer()
            Button(action: {
                //Button Action
                self.presentor?.userSelectedAddMoreAccounts()
                }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Try Again").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    Spacer()
                }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
                
                
            }
        }
    }
}


