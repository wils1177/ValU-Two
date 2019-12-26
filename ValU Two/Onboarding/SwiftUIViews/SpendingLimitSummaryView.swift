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
    
    init(leftToSpend: String){
        self.leftToSpend = leftToSpend

    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                VStack{
                    Text("$" + self.leftToSpend).font(.system(size: 50)).foregroundColor(.white).bold().padding()
                    Text("Left to Spend").font(.subheadline).foregroundColor(.white).bold()
                }
                Spacer()
            }.padding(.bottom)
            
            
        }.background(Color(.black)).cornerRadius(20).shadow(radius: 20)
    }
}


struct SpendingLimitSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingLimitSummaryView(leftToSpend: "5000")
    }
}

