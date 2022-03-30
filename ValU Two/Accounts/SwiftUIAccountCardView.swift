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
    var isSmall = false
    
    init(account: AccountData, isSmall: Bool = false){
        self.account = account
        self.isSmall = isSmall
    }
    
    func getBalance() -> String{
        if account.type == "credit"{
            return String(Int(account.balances!.current))
        }
        else{
            return String(Int(account.balances!.available))
        }
    }
    
    var largeCard: some View {
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Text(account.name!).font(.title).foregroundColor(.white).bold()
                    Spacer()
                    Image(systemName: "creditcard.fill").foregroundColor(Color(.white)).font(.system(size: 30))
                }
                
                Spacer()
                
                //Divider().foregroundColor(Color(.white))
                HStack{
                    Text(CommonUtils.makeMoneyString(number: Int(getBalance())!)).font(.title).bold().foregroundColor(.white)
                }
                HStack{
                    Text("XXXX" + (account.mask ?? "XXXX")).font(.headline).foregroundColor(Color(.lightText))
                   Spacer().frame(width: 60)
                }
                
                
            }
            Spacer()
        }.frame(height: 180).padding(10).background(LinearGradient(gradient:  Gradient(colors: [AppTheme().themeColorSecondary, AppTheme().themeColorPrimary]), startPoint: .topTrailing, endPoint: .center))
            .cornerRadius(24)
    }
    
    var smallCard : some View {
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Text(account.name!).font(.headline).foregroundColor(.white).bold()
                    Spacer()
                    Image(systemName: "creditcard.fill").foregroundColor(Color(.white)).font(.system(size: 17))
                }
                
                Spacer()
                
                //Divider().foregroundColor(Color(.white))
                HStack{
                    Text("$" + getBalance()).font(.headline).bold().foregroundColor(.white)
                }
                HStack{
                    Text("XXXX" + (account.mask ?? "XXXX")).font(.subheadline).foregroundColor(Color(.lightText))
                   Spacer().frame(width: 35)
                }
                
                
            }
            Spacer()
        }.frame(height: 110).padding(10).background(LinearGradient(gradient:  Gradient(colors: [AppTheme().themeColorSecondary, AppTheme().themeColorPrimary]), startPoint: .topTrailing, endPoint: .center))
            .cornerRadius(20)
    }
    
    var body: some View {
        if isSmall{
            smallCard
        }
        else{
            largeCard
        }
    }
}

/*
struct SwiftUIAccountCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAccountCardView()
    }
}
*/
