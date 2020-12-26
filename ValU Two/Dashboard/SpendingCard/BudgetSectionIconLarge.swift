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
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15).frame(width: size, height: size).foregroundColor(color)
            Image(systemName: self.icon).font(.system(size: size-29)).foregroundColor(Color(.white))
        }
    }
}


