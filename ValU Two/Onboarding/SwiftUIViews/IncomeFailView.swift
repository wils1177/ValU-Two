//
//  IncomeFailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeFailView: View {
    var body: some View {
        VStack(alignment: .center){
            Button(action: {
                //self.presentor?.userSelectedCTA()
            }){
                HStack{
                    ZStack{
                        Text("Estimate for me!").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    
                }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
                
                
            }
            Text("Woops! Couldn't calculate your income!").foregroundColor(.red).padding()

        }
    }
}

struct IncomeFailView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeFailView()
    }
}
