//
//  MarketingRow.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct MarketingRow: View {
    
    var imageName : String
    var headline: String
    var description: String
    
    var body: some View {
        HStack{
            
            //Image(systemName: self.imageName).font(.system(size: 35)).foregroundColor(AppTheme().themeColorPrimary).padding(.trailing)
            Text(self.imageName).font(.system(size: 45)).padding(.horizontal, 10).padding(. trailing, 5)
            VStack(alignment: .leading){
                
                Text(self.headline).font(.headline)//.padding(.bottom, 2)
                Text(self.description).font(.callout)//.foregroundColor(Color(.lightGray))
            }.padding(.trailing, 10)
            Spacer()
        }
    }
}


