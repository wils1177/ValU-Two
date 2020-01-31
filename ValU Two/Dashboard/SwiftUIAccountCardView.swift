//
//  SwiftUIAccountCardView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SwiftUIAccountCardView: View {
    
    let account : AccountViewData
    
    init(account: AccountViewData){
        self.account = account
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(account.name)
            Spacer().frame(height: 40)

            
            HStack{
                Text("$" + account.balance).font(.headline).fontWeight(.bold)
            }
            HStack{
                Text("XXXX" + account.mask).font(.footnote)
               Spacer().frame(width: 60)
            }
            
            
        }.padding().background(LinearGradient(gradient:  Gradient(colors: [.purple, .orange]), startPoint: .topTrailing, endPoint: .center))
            .cornerRadius(20).padding(.leading).padding(.trailing).shadow(radius: 5)
    }
}

/*
struct SwiftUIAccountCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAccountCardView()
    }
}
*/
