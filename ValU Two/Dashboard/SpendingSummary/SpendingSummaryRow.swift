//
//  SpendingSummaryRow.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingSummaryRow: View {
    
    var viewData : SpendingSummaryViewData
    
    init(viewData : SpendingSummaryViewData){
        self.viewData = viewData
    }
    
    var body: some View {
        
            
            GeometryReader{ g in
                
                ZStack{
                    HStack{
                        Rectangle().frame(width: (g.size.width) * CGFloat(self.viewData.percentage! - 0.02), height: 45).foregroundColor(Color(.systemFill)).cornerRadius(10)
                        Spacer()
                    }
                    
                        
                    HStack{
                        Text(self.viewData.icon).font(.headline).padding(.leading, 5)
                        Text(self.viewData.name).foregroundColor(Color(.white))//.bold()
                        Spacer()
                        Text(self.viewData.amount).foregroundColor(Color(.white)).padding(.trailing)
                        Text("(" + self.viewData.displayPercent + ")").foregroundColor(Color(.white))
                    }
                        
                    
                        
                    
                    
                    
                }
                
        }
            
            
            
            
            
        
        
    }
}


