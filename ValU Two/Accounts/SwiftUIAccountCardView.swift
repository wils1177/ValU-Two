//
//  SwiftUIAccountCardView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SwiftUIAccountCardView: View {
    
    let account : AccountData
    
    init(account: AccountData){
        self.account = account
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(account.name!).font(.title).bold()
            Spacer().frame(width: 300, height: 110)

            Divider()
            HStack{
                Text("$" + String(account.balances!.current)).font(.largeTitle)
            }
            HStack{
                Text("XXXX" + (account.mask ?? "XXXX")).font(.headline)
               Spacer().frame(width: 60)
            }
            
            
        }.padding().background(LinearGradient(gradient:  Gradient(colors: [.purple, .orange]), startPoint: .topTrailing, endPoint: .center))
            .cornerRadius(20).shadow(radius: 5)
    }
}

/*
struct SwiftUIAccountCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAccountCardView()
    }
}
*/
