//
//  AccountsAreLoadingView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct AccountsAreLoadingView: View {
    
    @State var animate = false
    var presentor : LoadingAccountsPresentor?
    
    init(presentor: LoadingAccountsPresentor?){
        self.presentor = presentor
    }
    
    
    var body: some View {
        VStack(alignment: .center){
            
            Image(systemName: "arrow.2.circlepath.circle.fill")
            .resizable()
                .frame(width:128, height: 128)
                .rotationEffect(.degrees(animate ? 360: 0))
                .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
                .onAppear(){
                    self.animate.toggle()
                    self.presentor?.viewWillLoad()
            }.foregroundColor(AppTheme().themeColorPrimary)
                .padding()
            Text("Loading Accounts...").bold()
            
            
            Button(action: {
                self.presentor?.transactionPull()
            }){
                
                HStack{
                    
                    ZStack{
                        Text("Done Hack").font(.subheadline).foregroundColor(.black).bold().padding()
                        
                        
                        
                    }
                    
                }
                
                
            }
            }.navigationBarTitle(Text("")).navigationBarHidden(true)
        
        

    }
}

struct AccountsAreLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsAreLoadingView(presentor: nil)
    }
}
