//
//  LoadingIncomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct LoadingIncomeView: View {
    
    @State var animate = false
    
    
    var body: some View {
        VStack(alignment: .center){
        
        Image(systemName: "arrow.2.circlepath.circle.fill")
        .resizable()
            .frame(width:50, height: 50)
            .rotationEffect(.degrees(animate ? 360: 0))
            .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
            .onAppear(){
                self.animate.toggle()
                //self.presentor?.viewWillLoad()
        }
            .padding()
            
            Text("Loading your income. This may take a few minutes")
        }
    }
}

struct LoadingIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIncomeView()
    }
}
