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
    var size = CGFloat(40)
    
    var body: some View {
        ZStack{
            Circle().frame(width: size, height: size).foregroundColor(color)
            Image(systemName: self.icon).font(.system(size: 19)).foregroundColor(Color(.white))
        }
    }
}


