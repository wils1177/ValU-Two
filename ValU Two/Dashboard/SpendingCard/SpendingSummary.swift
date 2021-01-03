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
    var detailed = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 2){
            
            
            
            if detailed{
                Text("$" + String(Int(self.spent)) + " Spent").font(.headline).foregroundColor(.white).bold()
                Text("$" + String(Int(self.limit)) + " Budgeted").font(.headline).foregroundColor(Color(.white)).bold()
            }
            else{
                Text("$" + String(Int(self.spent))).font(.subheadline).foregroundColor(.white).bold()
            }
            Spacer()
            
        }
    }
}


