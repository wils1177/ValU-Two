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
    
    func getBalance() -> String{
        if account.type == "credit"{
            return String(Int(account.balances!.current))
        }
        else{
            return String(Int(account.balances!.available))
        }
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Text(account.name!).font(.title).foregroundColor(.white).bold()
                    Spacer()
                    Image(systemName: "creditcard.fill").foregroundColor(Color(.white)).font(.system(size: 25))
                }
                
                Spacer()
                
                //Divider().foregroundColor(Color(.white))
                HStack{
                    Text("$" + getBalance()).font(.title).bold().foregroundColor(.white)
                }
                HStack{
                    Text("XXXX" + (account.mask ?? "XXXX")).font(.headline).foregroundColor(Color(.lightText))
                   Spacer().frame(width: 60)
                }
                
                
            }
            Spacer()
        }.frame(width: 280, height: 170).padding(10).background(LinearGradient(gradient:  Gradient(colors: [AppTheme().themeColorSecondary, AppTheme().themeColorPrimary]), startPoint: .topTrailing, endPoint: .center))
            .cornerRadius(20)
    }
}

/*
struct SwiftUIAccountCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAccountCardView()
    }
}
*/
