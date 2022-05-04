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
                    Text(account.name!).font(.system(size: 28, design: .rounded)).foregroundColor(.white).bold()
                    Spacer()
                    Image(systemName: "creditcard.fill").foregroundColor(Color(.white)).font(.system(size: 30))
                }
                
                Spacer()
                
                //Divider().foregroundColor(Color(.white))
                HStack{
                    Text(CommonUtils.makeMoneyString(number: Int(getBalance())!)).font(.system(size: 28, design: .rounded)).bold().foregroundColor(.white)
                }
                HStack{
                    Text("XXXX" + (account.mask ?? "XXXX")).font(.system(size: 20, design: .rounded)).foregroundColor(Color(.lightText))
                   Spacer().frame(width: 60)
                }
                
                
            }
            Spacer()
        }.frame(height: 180).padding(15).background(LinearGradient(gradient:  Gradient(colors: [AppTheme().themeColorSecondary, AppTheme().themeColorPrimary]), startPoint: .topTrailing, endPoint: .center))
            .cornerRadius(24).shadow(radius: 7).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).padding(5)
    }
    
    var smallCard : some View {
        HStack{
            VStack(alignment: .leading){
                HStack{
                    //Text(account.name!).font(.system(size: 7, design: .rounded)).foregroundColor(.white).bold()
                    //Spacer()
                    Image(systemName: "creditcard.fill").foregroundColor(Color(.white)).font(.system(size: 9))
                    Spacer()
                }
                
                Spacer()
                
                //Divider().foregroundColor(Color(.white))
                //HStack{
                //    Text("$" + getBalance()).font(.system(size: 10, design: .rounded)).bold().foregroundColor(.white)
               // }
                HStack{
                    Text("XXXX" + (account.mask ?? "XXXX")).font(.system(size: 8, design: .rounded)).foregroundColor(Color(.lightText))
                   
                }
                
                
            }
            Spacer()
        }.frame(width: 55, height: 40).padding(7).background(LinearGradient(gradient:  Gradient(colors: [AppTheme().themeColorSecondary, AppTheme().themeColorPrimary]), startPoint: .topTrailing, endPoint: .center))
            .cornerRadius(10).shadow(radius: 3)
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
