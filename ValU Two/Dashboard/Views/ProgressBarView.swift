//
//  ProgressBarView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {
    
    var width = CGFloat(290.0)
    var percentage : CGFloat
    var color: Color
    
    init(percentage : CGFloat, color: Color, width: Float = 290){
        self.percentage = percentage
        self.color = color
        self.width = CGFloat(width)
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
    
    var body: some View {
        
            
            ZStack(alignment: .leading){
            
                RoundedRectangle(cornerRadius: 20).frame(width: self.width, height: 12).foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                
                
                RoundedRectangle(cornerRadius: 20).frame(width: self.width * self.getPercentage(), height: 12).foregroundColor(self.color)

                
            }
        
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(percentage: CGFloat(0.75), color: Color(.orange))
    }
}
