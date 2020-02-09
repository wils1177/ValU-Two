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
    
    init(presentor: LoadingAccountsPresentor?){
        self.presentor = presentor
    }
    
    var body: some View {
        
        
        VStack(alignment: .center){
            
           Spacer()
            
            Text("Accounts Successfully Loaded").font(.title).bold().lineLimit(nil).padding().multilineTextAlignment(.center).padding(.bottom, 70)
            
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
                }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
                
                
            }
            
            
        }.navigationBarTitle(Text("Welcome"),  displayMode: .large)
        .navigationBarHidden(true)
    }
}

struct AccountsLoadedView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsLoadedView(presentor: nil)
    }
}
