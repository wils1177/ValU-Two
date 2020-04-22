//
//  SpendingSummaryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingSummaryView: View {
    
    
    @ObservedObject var viewModel : SpendingSummaryViewModel
    
    init(){
        self.viewModel = SpendingSummaryViewModel()
        
    }
    
    var animation: Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(3))
    }
    
    var body: some View {
        
        VStack{
        
        VStack{
        
        HStack{
            Spacer()
            Text("Spending Last 30 Days").font(.headline).bold().foregroundColor(Color(.white))
            Spacer()
        }.padding(.bottom)
            
        
            ForEach(self.viewModel.viewData, id: \.self){ entry in
            
            SpendingSummaryRow(viewData: entry).padding(.bottom).padding(.top)
             //Text("hey")
            }.transition(.slide)
        
        
        
        }.padding().padding(.bottom)
        
            HStack{
                Button(action: {
                    print("view condendsed")
                    withAnimation{
                        self.viewModel.toggleCondesnsed()
                    }
                    
                }){
                    
                    Text(self.viewModel.buttonText).foregroundColor(Color(.white))
                }.buttonStyle(PlainButtonStyle()).padding(.bottom).padding(.leading)
                Spacer()
            }
        

        }.background(Color(.systemTeal)).cornerRadius(10).shadow(radius: 15)
        
    }
        
}
    

struct SpendingSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingSummaryView()
    }
}
