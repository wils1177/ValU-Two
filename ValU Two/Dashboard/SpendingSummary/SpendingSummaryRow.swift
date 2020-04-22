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
                        Rectangle().frame(width: (g.size.width) * CGFloat(self.viewData.percentage!), height: 45).foregroundColor(Color(.systemFill)).cornerRadius(10).offset(x: CGFloat(-20))
                        Spacer()
                    }
                    
                        
                    HStack{
                        Text(self.viewData.icon).font(.headline)
                        Text(self.viewData.name).font(.subheadline).foregroundColor(Color(.white))
                        Spacer()
                        Text(self.viewData.amount).foregroundColor(Color(.white)).padding(.trailing)
                        Text("(" + self.viewData.displayPercent + ")").foregroundColor(Color(.white))
                        
                    }
                        
                    
                        
                    
                    
                    
                }
                
        }
            
            
            
            
            
        
        
    }
}


