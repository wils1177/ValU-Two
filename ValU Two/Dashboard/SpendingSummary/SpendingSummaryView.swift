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
    
    @State var showMore = false
    
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
        
            VStack(alignment: .leading){
        
        HStack{
            Text("Spent Last 30 Days").font(.headline).bold().foregroundColor(Color(.black))
            Spacer()
            
            if self.viewModel.viewData.count > 5 {
                Button(action: {
                    withAnimation{
                        self.showMore.toggle()
                    }
                    
                }){
                    Text(self.viewModel.buttonText).foregroundColor(AppTheme().themeColorPrimary).font(.callout)

                    }.buttonStyle(PlainButtonStyle()).padding(.trailing, 5)
            }
            
            
        }
            
        
            ForEach(self.viewModel.viewData, id: \.self){ entry in
                
                VStack(spacing: 0.0){
                    if self.viewModel.viewData.firstIndex(of: entry)! < 5 || self.showMore{
                        SpendingSummaryRow(viewData: entry).padding(.bottom).padding(.top).padding(.horizontal, 3)
                    }
                }
                
            }
        
        
        }.padding().padding(.bottom, 5)
            
            /*
            if self.viewModel.viewData.count > 5 {
                Divider().padding(.bottom, 5)
                Button(action: {
                    withAnimation{
                        self.showMore.toggle()
                    }
                    
                }){
                    HStack{
                        Text(self.viewModel.buttonText).foregroundColor(Color(.white))
                        Spacer()
                        if !self.showMore{
                            Image(systemName: "arrow.down").padding(.trailing).foregroundColor(Color(.white))
                        }
                        else{
                            Image(systemName: "arrow.up").padding(.trailing).foregroundColor(Color(.white))
                        }
                        
                    }
                    
                }.buttonStyle(PlainButtonStyle()).padding(.bottom).padding(.leading)
            }
            */
                
                
            
        

        }.animation(.easeInOut(duration: 0.6)).background(Color(.white)).cornerRadius(15)//.shadow(radius: 10)
        
    }
        
}
    

struct SpendingSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingSummaryView()
    }
}
