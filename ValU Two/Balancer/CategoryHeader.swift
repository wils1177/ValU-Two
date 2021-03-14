//
//  CategoryHeader.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryHeader: View {
    
    var name : String
    
    var body: some View {
        HStack(){
            //Text(self.icon).font(.system(size: 22)).bold()
            Text(self.name).font(.system(size: 18, design: .rounded)).bold().lineLimit(1)
            Spacer()

        }
    }
}


