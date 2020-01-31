//
//  BudgetCategoryIconView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/24/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetCategoryIconView: View {
    
    var icon : String
    var percentage : CGFloat
    
    init(icon:String, percentage: CGFloat){
        self.icon = icon
        self.percentage = percentage
      
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
        ZStack{
            Text(self.icon).font(.headline)
            Circle().fill(Color.clear).frame(width:40, height: 40)
                .overlay(Circle()
                        .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: CGFloat(1.0))
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(3.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                        
                )
                .overlay(Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: self.getPercentage())
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(3.0), lineCap: .round, lineJoin: .round))
                    .fill(getColor())
                    
            )
            
        }
        
    }
}

struct BudgetCategoryIconView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCategoryIconView(icon: "5", percentage: 0.5)
    }
}
