//
//  SectionTitleView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SectionTitleView: View {
    
    var title : String
    
    var body: some View {
        HStack{
            Text(self.title).font(.system(.title, design: .rounded)).bold()
            Spacer()
        }
    }
}

