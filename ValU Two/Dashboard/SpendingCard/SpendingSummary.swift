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
        VStack(alignment: .trailing, spacing: 2){
            
            Text("$" + String(Int(self.spent)) + " spent").font(.headline).foregroundColor(.white).bold()
            Text("$" + String(Int(self.limit)) + " budgeted").font(.headline).foregroundColor(Color(.white)).bold().padding(.bottom, 2)
            Spacer()
            
        }
    }
}


