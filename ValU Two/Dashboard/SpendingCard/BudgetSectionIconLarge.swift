//
//  BudgetSectionIconLarge.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetSectionIconLarge: View {
    
    var color : Color
    var icon : String = "backward.end.fill"
    var size = CGFloat(55)
    var multiColor : Bool = false
    
    var body: some View {
        ZStack(alignment: .center){
            if multiColor{
                RoundedRectangle(cornerRadius: 15).frame(width: size, height: size).foregroundColor(Color(.clear)).background(LinearGradient(gradient: Gradient(colors: [colorMap[0], colorMap[1], colorMap[2], colorMap[3]]), startPoint: .top, endPoint: .bottom)).cornerRadius(15)
            }
            else{
                RoundedRectangle(cornerRadius: 15).frame(width: size, height: size).foregroundColor(color)
            }
            
            Image(systemName: self.icon).font(.system(size: size / 2)).foregroundColor(Color(.white))
        }
    }
}


