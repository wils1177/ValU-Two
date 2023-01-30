//
//  IconSelectionGridView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/8/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IconSelectionGridView: View {
    
    @Binding var icons : [String]
    @Binding var selectedIcon : String
    
    
    func isSelectedI(icon: String) -> Bool{
        if icon == self.selectedIcon{
            return true
        }
        else{
            return false
        }
    }
    
    func changeSelection(icon: String){
        self.selectedIcon = icon
        
    }
    
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
            GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
        
        
        
        ]
    

    var iconSelectionGrid : some View{
        
        VStack{
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<self.icons.count, id: \.self){ col in
                            
                            Button(action: {
                                
                                self.changeSelection(icon: self.icons[col])
                                
                                    }){
                                        Spacer()
                                        if self.isSelectedI(icon: self.icons[col]){
                                            ZStack{
                                                Circle().frame(width: 45, height: 45).foregroundColor(Color(.systemFill))
                                                Image(systemName: self.icons[col]).font(Font.system(size: 20)).foregroundColor(Color(.black))
                                            }.overlay(
                                                Circle()
                                                    .stroke(AppTheme().themeColorPrimary, lineWidth: 3).padding(2)
                                                ).padding(.vertical, 5)
                                            
                                        }else{
                                            ZStack{
                                                Circle().frame(width: 45, height: 45).foregroundColor(Color(.systemFill))
                                                Image(systemName: self.icons[col]).font(Font.system(size: 20)).foregroundColor(Color(.black))
                                            }.overlay(
                                                Circle()
                                                    .stroke(Color(.clear), lineWidth: 3).padding(2)
                                                ).padding(.vertical, 5)
                                        }
                                        Spacer()
                                }
                            
                            
                        
                    
                }
                
            }
            
        }
        

        
    }
    
    var body: some View {
        iconSelectionGrid
    }
}


