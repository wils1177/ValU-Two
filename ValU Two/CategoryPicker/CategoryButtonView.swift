//
//  CategoryButtonView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryButtonView: View {
    
    @ObservedObject var category : SpendingCategory
    
    func getButtonColor() -> Color {
        if category.selected{
            
            return .green
        }
        else{
            return .black
        }
    }
    

    
    init(category: SpendingCategory ){
        self.category = category
    }
    
    
    var body: some View {
        
        Button(action: {
            self.category.selected.toggle()
            
        }){
            HStack{

                Text(category.icon! + category.name!).font(.headline).padding()
                Spacer()
                Image(systemName: "plus.circle.fill").imageScale(.large).foregroundColor(self.getButtonColor()).padding(.trailing)        
                
            }
    }
}
    
}


