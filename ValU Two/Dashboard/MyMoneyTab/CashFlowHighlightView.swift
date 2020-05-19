//
//  CashFlowHighlightView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CashFlowHighlightView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "dollarsign.circle.fill").foregroundColor(Color(.systemGreen))
                Text("Cash Flow").font(.headline).foregroundColor(Color(.systemGreen))
                Spacer()
            }
            HStack{
                
                Text("Your net cash flow is higher this month than last month.").font(.headline).bold().lineLimit(2).multilineTextAlignment(.leading)
                Spacer()
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 5){
                HStack(alignment: .bottom){
                    Text("$2,345").font(.title).bold()
                    Text("Net Cash Flow").font(.headline).foregroundColor(Color(.lightGray)).bold()
                    
                }
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 5).frame(width: 280, height: 32).foregroundColor(Color(.systemGreen))
                    Text("May").foregroundColor(Color(.white)).bold().padding(.leading)
                }
            }.padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 5){
                HStack(alignment: .bottom){
                    Text("$1,345").font(.title).bold()
                    Text("Net Cash Flow").font(.headline).foregroundColor(Color(.lightGray)).bold()
                }
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 5).frame(width: 200, height: 32).foregroundColor(Color(.tertiarySystemFill))
                    Text("April").bold().padding(.leading)
                }
            }
            
        }.padding().background(Color(.white)).cornerRadius(15)//.shadow(radius: 3)
    }
}


