//
//  SpendingLimitSummaryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/5/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingLimitSummaryView: View {
    var body: some View {
        VStack{
            HStack{
                Text("0$").font(.largeTitle).foregroundColor(.white).bold()
                Text("Spent Out Of").font(.headline).foregroundColor(.white).bold()
                Text("3500$").font(.largeTitle).foregroundColor(.white).bold()
            }.padding(.top).padding(.leading).padding(.trailing)
            
            ZStack{
                

                HStack{
                    Rectangle().frame(height: 5).foregroundColor(Color(.white))
                    
                    }.cornerRadius(10).padding(.horizontal).shadow(radius: 20)
                
                HStack{
                    Rectangle().frame(width: 120, height: 5).foregroundColor(Color(.red))
                    Spacer()
                }.cornerRadius(1).padding(.horizontal)
                
                
                
            }.padding(.bottom)
        }.background(Color(.black)).cornerRadius(20).shadow(radius: 20)
    }
}

struct SpendingLimitSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingLimitSummaryView()
    }
}
