//
//  BalanceDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BalanceDetailView: View {
    var body: some View {
        VStack{
                
                HStack{
                    Text("🍔").font(.largeTitle)
                    Text("poop butt").font(.headline).fontWeight(.bold)
                    Spacer()
                    Text("$1").font(.headline).fontWeight(.bold)
                    
                    
                }.padding()
                HStack{
                    Text("You've Spent $100 Bucks here in the time").font(.callout).fontWeight(.bold)
                    Spacer()
                }.padding(.leading).padding(.trailing).padding(.bottom)
                
                
                }.background(Color(.white)).cornerRadius(10).shadow(radius: 5)
    }
}


struct BalanceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceDetailView()
    }
}
