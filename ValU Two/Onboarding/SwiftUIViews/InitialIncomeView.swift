//
//  InitialIncomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct InitialIncomeView: View {
    
    var presentor : EnterIncomePresentor?
    
    init(presentor: EnterIncomePresentor?){
        self.presentor = presentor
    }
    
    
    var body: some View {
        Button(action: {
            self.presentor?.userRequestedIncome()
        }){
            HStack{
                ZStack{
                    Text("Estimate for me!").font(.subheadline).foregroundColor(.white).bold().padding()
                }
                
            }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
            
            
        }
    }
}

struct InitialIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        InitialIncomeView(presentor: nil)
    }
}
