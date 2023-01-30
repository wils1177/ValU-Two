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
            
            
            
            VStack(alignment: .leading, spacing: 0){
                
                
                
                HStack{
                    //Image(systemName: "creditcard.fill").font(.system(size: 18, design: .rounded)).foregroundColor(Color(.lightGray))
                    Text("Available Balance").font(.system(size: 16, design: .rounded)).bold().foregroundColor(Color(.lightGray))
                }
                
                Text(balanceTotal).font(.system(size: 31, design: .rounded)).fontWeight(.heavy).foregroundColor(globalAppTheme.themeColorPrimary)
                
            }
            Spacer()
        }
    }
}


