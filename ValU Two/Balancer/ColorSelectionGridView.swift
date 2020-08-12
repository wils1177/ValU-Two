//
//  ColorSelectionGridView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/6/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ColorSelectionGridView: View {
    
    @Binding var colors : [[Int]]
    @Binding var selectedRow : Int
    @Binding var selectedColumn : Int
    
    
    
    func isSelectedI(row: Int, col: Int) -> Bool{
        if row == self.selectedRow && col == self.selectedColumn{
            return true
        }
        else{
            return false
        }
    }
    
    
    func changeSelection(row: Int, col: Int){
        self.selectedRow = row
        self.selectedColumn = col
        
    }
    
    var body: some View {
        VStack{
            ForEach(0..<self.colors.count, id: \.self){ row in
                HStack{
                    ForEach(0..<self.colors[row].count, id: \.self){ col in
                        
                        Button(action: {
                            print(row)
                            print(col)
                            self.changeSelection(row: row, col: col)
                            
                                }){
                                    Spacer()
                                    if self.isSelectedI(row: row, col: col){
                                        Circle().frame(width: 40, height: 40).foregroundColor(colorMap[self.colors[row][col]]).padding(4).overlay(
                                            Circle()
                                                .stroke(Color.gray, lineWidth: 3).padding(2)
                                            ).cornerRadius(12).padding(.vertical, 5)
                                    }else{
                                        Circle().frame(width: 40, height: 40).foregroundColor(colorMap[self.colors[row][col]]).padding(4).overlay(
                                            Circle()
                                                .stroke(Color.clear, lineWidth: 3).padding(2)
                                        ).cornerRadius(12).padding(.vertical, 5)
                                    }
                                    Spacer()
                            }
                        
                        
                    }
                }
            }
        }
    }
}


