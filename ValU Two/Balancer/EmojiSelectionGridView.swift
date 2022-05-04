//
//  EmojiSelectionGridView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/10/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EmojiSelectionGridView: View {
    
    
    @Binding var icons : [String]
    
    @Binding var selectedIcon : String

    @State var selectedColumn : Int = 0
    
    func isSelectedI(col: Int) -> Bool{
        if col == self.selectedColumn{
            return true
        }
        else{
            return false
        }
    }
    
    func changeSelection(col: Int){
        self.selectedColumn = col
        self.selectedIcon = icons[col]
    }
    
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
            GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
        
        
        
        
        ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<self.icons.count, id: \.self){ col in
                    
                        
                        Button(action: {
                            print(col)
                            self.changeSelection(col: col)
                            
                                }){
                                    Spacer()
                                    if self.isSelectedI(col: col){
                                        EmojiIcon(emoji: self.icons[col], color: Color(.systemFill))
                                        
                                        
                                    }else{
                                        EmojiIcon(emoji: self.icons[col], color: Color(.clear))
                                    }
                                    Spacer()
                            }
                        
                        
                    
                
            }
        }
    }
}

struct EmojiIcon: View {
    
    var emoji : String
    var color : Color
    
    var body : some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20).frame(width: 50, height: 50).foregroundColor(self.color)
            Text(self.emoji).font(.system(size: 32)).foregroundColor(Color(.black))
        }.padding(.vertical, 5)
    }
    
    
    
}


