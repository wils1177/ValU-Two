//
//  HistoryEntryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoryEntryView: View {
    
    var viewData : HistoryEntryViewData
        
    init(viewData : HistoryEntryViewData){
        self.viewData = viewData
    }
    

    
    
    var body: some View {
        VStack{
            HStack{
                Text(self.viewData.title).font(.title).fontWeight(.bold)
                Spacer()
            }
            HStack{
                
                HStack{
                    
                    //Spacer()
                    VStack{
                        Text(self.viewData.spent).font(.system(size: 28)).fontWeight(.bold)
                        Text("Spent").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                    }
                    
                    
                }.padding(.leading).padding(.leading)

                Spacer()
                
                HStack{
                    
                    
                    VStack{
                        //Spacer()
                        Text(self.viewData.remaining).font(.system(size: 28)).fontWeight(.bold)
                        Text("Saved").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                        
                    }
                    
                    
                }.padding(.trailing).padding(.trailing).padding(.top)
                
            }
            
        
            
            ProgressBarView(percentage: self.viewData.percentage, color: Color(.black))
            SpendingCardDropDownView(viewData: self.viewData.spendingCardViewData)
            
            
            
            
            
            
        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 8).padding(.leading).padding(.trailing).padding(.bottom)
    }
}


