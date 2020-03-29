//
//  SpendingLimitSummaryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/5/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingLimitSummaryView: View {
    
    var leftToSpend : String
    var percentage : Float
    
    init(leftToSpend: String, percentage: Float){
        self.leftToSpend = leftToSpend
        self.percentage = percentage
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text(self.leftToSpend).font(.system(size: 30)).foregroundColor(.black).bold()
                
                Spacer()
                
            }.padding(.horizontal).padding(.top)
            HStack{
                Spacer()
                Text("left to budget").font(.system(size: 17)).foregroundColor(.black)
                Spacer()
            }
            HStack{
                ProgressBarView(percentage: CGFloat(self.percentage), color: Color(.green)).padding(.bottom)
            }
            
            
        }.background(Color(.white))
    }
}




