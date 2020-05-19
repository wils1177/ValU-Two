//
//  BalanceSummaryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BalanceSummaryView: View {
    
    let viewModel = BalanceSummaryViewModel()
    var balanceTotal : String
    
    init(){
        self.balanceTotal = CommonUtils.makeMoneyString(number: Int(self.viewModel.totalAccountBalance))
    }
    
    var body: some View {
        HStack{
            //Spacer()
            
            
            VStack(alignment: .leading, spacing: 0){
                
                HStack{
                    Image(systemName: "creditcard.fill").foregroundColor(Color(.lightGray))
                    Text("Available Balance").font(.headline).bold().foregroundColor(Color(.lightGray))
                }
                
                Text(balanceTotal).font(.system(size: 43)).bold().padding(.top, 10)
                
            }
            Spacer()
        }.padding().background(Color(.white)).cornerRadius(15)
    }
}


