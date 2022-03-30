//
//  ProgressBarView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {
    
    var percentage : CGFloat
    var color: Color
    
    var background: Color
    
    init(percentage : CGFloat, color: Color, backgroundColor: Color = Color(.clear)){
        self.percentage = percentage
        self.color = color
        self.background = backgroundColor
    }
    
    func getColor() -> Color {
        if self.percentage >= 1.0{
            return Color(hue: 0.0, saturation: 0.35, brightness: 1.0)
        }
        else if self.percentage < 1.0 && self.percentage > 0.75{
            return Color(hue: 0.167, saturation: 0.35, brightness: 1.0)
        }
        else{
            return Color(hue: 0.255, saturation: 0.35, brightness: 1.0)
        }
    }
    
    func getPercentage() -> CGFloat{
        if self.percentage >= CGFloat(1.0){
            return CGFloat(0.999)
        }
        else if self.percentage < 0.02 {
            return CGFloat(0.05)
        }
        else{
            return self.percentage
        }
    }
    
    var coloredBar : some View{
        
        GeometryReader{ g in
            HStack{
                RoundedRectangle(cornerRadius: 20).frame(width: g.size.width * self.getPercentage()).foregroundColor(self.color)
                Spacer()
            }
            
            
        }.frame(height: 10)
        
    }
    
    var fullBar : some View{
        
        Rectangle().frame(height: 10).foregroundColor(self.background)
        
    }
    
    var body: some View {
        
            
            ZStack(alignment: .leading){
            
                fullBar
                
                
                coloredBar
                //Text("hy")
                
            }.clipShape(Capsule())
        
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(percentage: CGFloat(0.75), color: Color(.orange))
    }
}
