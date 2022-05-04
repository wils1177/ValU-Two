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
    
    func getPercentage(percentage: Float) -> Float{
        print("percentager is")
        print(percentage)
        if percentage > 0.15{
            return percentage
        }
        else{
            return 0.15
        }
    }
    
    func getTextColor() -> Color{
        if self.viewData.percentage! >= 0.40{
            return Color(.white)
        }
        else{
            return AppTheme().themeColorPrimary
        }
    }
    
    var body: some View {
        
            
            GeometryReader{ g in
                
                ZStack(alignment: .leading){
                    
                    ZStack(alignment: .leading){
                        
                        
                        HStack{
                            Text(self.viewData.icon).font(.headline).padding(.leading, 5)
                            Text(self.viewData.name).foregroundColor(AppTheme().themeColorPrimary).bold()
                            Spacer()
                            Text(self.viewData.amount).foregroundColor(Color(.black)).fontWeight(.semibold).padding(.trailing)
                            //Text("(" + self.viewData.displayPercent + ")").foregroundColor(Color(.black))
                        }
                        
                    }
                    
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 10).frame(width: (g.size.width), height: 40).foregroundColor(Color(.lightGray).opacity(0.7))
                        
                        RoundedRectangle(cornerRadius: 10).frame(width: (g.size.width), height: 40).overlay(LinearGradient(gradient: Gradient(colors: [AppTheme().themeColorSecondary, AppTheme().themeColorPrimary]), startPoint: .leading, endPoint: .trailing))
                        
                        HStack{
                            Text(self.viewData.icon).font(.headline).padding(.leading, 5)
                            Text(self.viewData.name).foregroundColor(Color(.white)).bold()
                            Spacer()
                            Text(self.viewData.amount).foregroundColor(Color(.white)).fontWeight(.semibold).padding(.trailing)
                            //Text("(" + self.viewData.displayPercent + ")").foregroundColor(Color(.black))
                        }
                        
                        //Rectangle().frame(width: (g.size.width), height: 40).foregroundColor(Color(.tertiarySystemFill)).cornerRadius(10)
                    }.fixedSize(horizontal: true, vertical: false).frame(width: (g.size.width) * CGFloat(self.getPercentage(percentage: self.viewData.percentage!)), alignment: .leading).clipped().cornerRadius(10)
                    
                        
          
                    
                        
                    
                    
                    
                }
                
        }
            
            
            
            
            
        
        
    }
}


