//
//  SwiftUIAccountsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SwiftUIAccountsView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Your Accounts").font(.headline).padding()
                Spacer()
                
            }
            
        
            // statuses
            ScrollView(.horizontal, content: {
                HStack(spacing: 0) {
                    SwiftUIAccountCardView()
                    SwiftUIAccountCardView()
                    SwiftUIAccountCardView()
                }
                .padding()
            })
            .frame(height: 140)
            
            
            
            
            
        }
        
    }
}

struct SwiftUIAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAccountsView()
    }
}
