//
//  SwiftUIAccountCardView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SwiftUIAccountCardView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("MSUFCU")
            Spacer().frame(height: 40)

            
            HStack{
                Text("$5000.00").font(.headline).fontWeight(.bold)
            }
            HStack{
               Text("  XXXX 1234").font(.footnote)
               Spacer().frame(width: 60)
            }
            
            
        }.padding().background(LinearGradient(gradient:  Gradient(colors: [.orange, .yellow]), startPoint: .topTrailing, endPoint: .center))
            .cornerRadius(20).padding().shadow(radius: 10)
    }
}

struct SwiftUIAccountCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAccountCardView()
    }
}
