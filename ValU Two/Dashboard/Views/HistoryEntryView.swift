//
//  HistoryEntryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoryEntryView: View {
    
    
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Month").font(.title).fontWeight(.bold)
                Spacer()
            }
            HStack{
                
                HStack{
                    
                    //Spacer()
                    VStack{
                        Text("$500").font(.system(size: 28)).fontWeight(.bold)
                        Text("Spent").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                    }
                    
                    
                }.padding(.leading).padding(.leading)

                Spacer()
                
                HStack{
                    
                    
                    VStack{
                        //Spacer()
                        Text("$1000").font(.system(size: 28)).fontWeight(.bold)
                        Text("Saved").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                        
                    }
                    
                    
                }.padding(.trailing).padding(.trailing).padding(.top)
                
            }.padding(.bottom)
            
            
            
            
            
            
            
            
            ProgressBarView(percentage: 0.5, color: Color(.black))
            
            
            
            
            
            
        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 20).padding(.leading).padding(.trailing).padding(.bottom)
    }
}

struct HistoryEntryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryEntryView()
    }
}
