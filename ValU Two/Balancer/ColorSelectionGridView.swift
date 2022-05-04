//
//  ColorSelectionGridView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/6/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ColorSelectionGridView: View {
    
    @Binding var colors : [Int]
    @Binding var selectedColumn : Int
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
            GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
        
        
        
        ]
    
    
    func isSelected(col: Int) -> Bool{
        if col == self.selectedColumn{
            return true
        }
        else{
            return false
        }
    }
    
    
    func changeSelection(col: Int){
        self.selectedColumn = col
        
    }
    
    var body: some View {
        VStack{
            ScrollView() {
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(self.colors, id: \.self){ col in
                            
                            Button(action: {
                                print(col)
                                self.changeSelection(col: col)
                                
                                    }){
                                        Spacer()
                                        if self.isSelected(col: col){
                                            Circle().frame(width: 35, height: 35).foregroundColor(colorMap[self.colors[col]]).padding(4).overlay(
                                                Circle()
                                                    .stroke(AppTheme().themeColorPrimary, lineWidth: 3).padding(2)
                                                ).padding(.vertical, 5)
                                        }else{
                                            Circle().frame(width: 35, height: 35).foregroundColor(colorMap[self.colors[col]] as! Color).padding(4).overlay(
                                                Circle()
                                                    .stroke(Color.clear, lineWidth: 3).padding(2)
                                            ).padding(.vertical, 5)
                                        }
                                        Spacer()
                                }
                            
                            
                        }
                            }
                
                
                
                }
            
        }
    }
}


