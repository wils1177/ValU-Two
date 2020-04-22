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
        self.balanceTotal = "$" + String(Int(self.viewModel.totalAccountBalance))
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Balance").font(.headline).bold()
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Text(self.balanceTotal).font(.system(size: 40)).bold()
                Spacer()
            }
            Spacer()
        }.frame(height: 120).padding().background(Color(.white)).cornerRadius(10).shadow(radius: 3)
    }
}


