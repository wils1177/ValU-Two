//
//  SwiftUISavingsCardView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/13/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SwiftUISavingsCardView: View {
    var body: some View {
        VStack{
        VStack(alignment: .leading) {
            HStack{
                Text("Savings").font(.title)
                Spacer()
            }

            HStack{
                Text("Monthly Savings Goal")
                    Spacer()
                Text("$500.00").font(.subheadline).fontWeight(.bold)
                
            }
            HStack{
                Text("Saved to date:")
                    Spacer()
                Text("$10,000.00").fontWeight(.bold)
                
            }
            }.padding().background(Color(.white)).cornerRadius(20).padding().shadow(radius: 20)
        
        
        }
    }
}

struct SwiftUISavingsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUISavingsCardView()
    }
}
