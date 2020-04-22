//
//  TransactionIconView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/29/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionIconView: View {
    
    var icons : [String]
    
    
    var body: some View {
        VStack{
            
            if icons.count == 1{
                Text(icons[0]).font(.largeTitle).offset(x: 0, y: 0)
            }
            else if icons.count == 2{
                VStack{
                    Text(icons[0]).font(.headline)//.offset(x: -10, y: 0)
                    Text(icons[1]).font(.headline)//.offset(x: 10, y: 0)
                }
            }
            else if icons.count > 2{
                ZStack{
                    Text(icons[0]).font(.headline).offset(x: -10, y: -10)
                    Text(icons[1]).font(.headline).offset(x: 10, y: -10)
                    Text(icons[2]).font(.headline).offset(x: 0, y: 10)
                }.padding(.horizontal, 5)
            }
            
        }
        
        
    }
}


