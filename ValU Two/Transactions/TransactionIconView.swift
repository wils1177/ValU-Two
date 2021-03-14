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
    var iconSize : CGFloat = 32
    
    
    var one : some View{
        VStack{
            Text(self.icons[0]).font(.system(size: iconSize)).offset(x: 0, y: 0)
        }
        
    }
    
    var two: some View{
        VStack(alignment: .center){
            Text(self.icons[0]).font(.system(size: 12))//.offset(x: -10, y: 0)
            Text(self.icons[1]).font(.system(size: 12))//.offset(x: 10, y: 0)
        }
        
    }
    
    var more : some View{
        ZStack(alignment: .center){
            Text(self.icons[0]).font(.system(size: 15)).offset(x: -10, y: -10)
            Text(self.icons[1]).font(.system(size: 15)).offset(x: 10, y: -10)
            Text(self.icons[2]).font(.system(size: 15)).offset(x: 0, y: 10)
        }
    }
    
    @ViewBuilder
    var mainPart: some View{
            
            if icons.count == 1{
                self.one
            }
            else if icons.count == 2{
                
                    self.two
                
            }
            else if icons.count > 2{
                self.more
            }
            
        
    }
    
    var body: some View {
        self.mainPart.padding(.horizontal, (self.iconSize / 15.5)).padding((self.iconSize / 3.1)).background(Color(.tertiarySystemGroupedBackground).opacity(0.6)).cornerRadius(20)
        
        
    }
}


struct TransactionIconViewLarge: View {
    
    var icons : [String]
    var iconSize : CGFloat = 70
    
    
    var one : some View{
        VStack{
            Text(self.icons[0]).font(.system(size: iconSize)).offset(x: 0, y: 0)
        }
        
    }
    
    var two: some View{
        VStack(alignment: .center){
            Text(self.icons[0]).font(.system(size: 12))//.offset(x: -10, y: 0)
            Text(self.icons[1]).font(.system(size: 12))//.offset(x: 10, y: 0)
        }
        
    }
    
    var more : some View{
        ZStack(alignment: .center){
            Text(self.icons[0]).font(.system(size: 15)).offset(x: -10, y: -10)
            Text(self.icons[1]).font(.system(size: 15)).offset(x: 10, y: -10)
            Text(self.icons[2]).font(.system(size: 15)).offset(x: 0, y: 10)
        }
    }
    
    @ViewBuilder
    var mainPart: some View{
            
            if icons.count == 1{
                self.one
            }
            else if icons.count == 2{
                
                    self.two
                
            }
            else if icons.count > 2{
                self.more
            }
            
        
    }
    
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 35).frame(width: 125, height: 125, alignment: .center).foregroundColor(Color(.tertiarySystemGroupedBackground).opacity(0.6))
            self.mainPart
        }
        
        
        
    }
}

