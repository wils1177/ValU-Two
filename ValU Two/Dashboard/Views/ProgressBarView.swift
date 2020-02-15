//
//  ProgressBarView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {
    
    var width = CGFloat(320.0)
    var percentage : CGFloat
    var color: Color
    
    init(percentage : CGFloat, color: Color){
        self.percentage = percentage
        self.color = color
    }
    
    func getColor() -> LinearGradient {
        if self.percentage >= 1.0{
            return LinearGradient(gradient:  Gradient(colors: [.orange, .red]), startPoint: .topTrailing, endPoint: .center)
        }
        else if self.percentage < 1.0 && self.percentage > 0.75{
            return LinearGradient(gradient:  Gradient(colors: [.yellow, .orange]), startPoint: .topTrailing, endPoint: .center)
        }
        else{
            return LinearGradient(gradient:  Gradient(colors: [.green, .yellow]), startPoint: .topTrailing, endPoint: .center)
        }
    }
    
    func getPercentage() -> CGFloat{
        if self.percentage >= CGFloat(1.0){
            return CGFloat(1.0)
        }
        else{
            return self.percentage
        }
    }
    
    var body: some View {
        
        HStack{
            
            ZStack(alignment: .leading){
            
                Rectangle().frame(width: self.width, height: 21).foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9)).cornerRadius(10)
                
                
                Rectangle().frame(width: self.width * self.getPercentage(), height: 21).foregroundColor(.clear)
                    .background(self.getColor()).cornerRadius(10)

                
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(percentage: CGFloat(0.75), color: Color(.orange))
    }
}
