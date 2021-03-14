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
            Spacer()
            
            
            VStack(alignment: .center, spacing: 0){
                
                HStack{
                    Image(systemName: "creditcard.fill").font(.system(size: 18, design: .rounded)).foregroundColor(Color(.lightGray))
                    Text("Available Balance").font(.system(size: 18, design: .rounded)).bold().foregroundColor(Color(.lightGray))
                }
                
                Text(balanceTotal).font(.system(size: 43, design: .rounded)).bold().bold().padding(.top, 3)
                
            }
            Spacer()
        }.padding()
    }
}


