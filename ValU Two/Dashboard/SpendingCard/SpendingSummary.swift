//
//  SpendingSummary.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingSummary: View {
    
    var spent : Float
    var limit : Float
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 2){
            
            Text("$" + String(Int(self.spent))).font(.title).foregroundColor(.black).bold()
            Text(" / " + "$" + String(Int(self.limit))).font(.headline).foregroundColor(Color(.lightGray)).bold().padding(.bottom, 5)
            Spacer()
            
        }.padding(.horizontal).padding(.top, 5).padding(.bottom, 10).padding(.leading)
    }
}


