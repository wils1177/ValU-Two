//
//  CategoryButtonView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryButtonView<Model>: View where Model: CategorySelecter {
    
    @ObservedObject var button : CategoryButton
    var presentor : Model
    
    func getButtonColor() -> Color {
        if button.selected{
            
            return .green
        }
        else{
            return .black
        }
    }
    
    func editCategory(){
        let originalName = self.button.name
        if button.selected{
            self.presentor.selectedCategoryName(name: originalName)
        }
        else{
            self.presentor.deSelectedCategoryName(name: originalName)
        }
    }
    
    init(presentor: Model, button: CategoryButton ){
        self.presentor = presentor
        self.button = button
    }
    
    
    var body: some View {
        
        Button(action: {
            self.button.selected.toggle()
            self.editCategory()
            
        }){
            HStack{
                
                
                Text(button.icon + button.name).font(.footnote).foregroundColor(.white).padding()
                
                
            }.background(self.getButtonColor()).cornerRadius(20).shadow(radius: 5)
    }
}
    
}


