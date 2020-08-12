//
//  EmojiSelectionGridView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/10/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EmojiSelectionGridView: View {
    
    
    @Binding var icons : [[String]]
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
            ForEach(0..<self.icons.count, id: \.self){ row in
                HStack{
                    ForEach(0..<self.icons[row].count, id: \.self){ col in
                        
                        Button(action: {
                            print(row)
                            print(col)
                            self.changeSelection(row: row, col: col)
                            
                                }){
                                    Spacer()
                                    if self.isSelectedI(row: row, col: col){
                                        ZStack{
                                            Circle().frame(width: 45, height: 45).foregroundColor(Color(.gray))
                                            Text(self.icons[row][col]).font(.headline).foregroundColor(Color(.black))
                                        }.padding(.vertical, 5)
                                        
                                    }else{
                                        ZStack{
                                            Circle().frame(width: 45, height: 45).foregroundColor(Color(.systemFill))
                                            Text(self.icons[row][col]).font(.headline).foregroundColor(Color(.black))
                                        }.padding(.vertical, 5)
                                    }
                                    Spacer()
                            }
                        
                        
                    }
                }
            }
        }
    }
}


