//
//  CategoryButtonView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryButtonView: View {
    
    var categoryName: String
    @State var selected : Bool = false
    var presentor : BudgetCardsPresentor?
    
    func getButtonColor() -> Color {
        if selected{
            
            return .green
        }
        else{
            return .black
        }
    }
    
    func editCategory(){
        if selected{
            self.presentor?.selectedCategoryName(name: self.categoryName)
        }
        else{
            self.presentor?.deSelectedCategoryName(name: self.categoryName)
        }
    }
    
    init(presentor: BudgetCardsPresentor?, text: String){
        self.categoryName = text
        self.presentor = presentor
    }
    
    
    var body: some View {
        
        Button(action: {
            self.selected.toggle()
            self.editCategory()
            
        }){
            HStack{
                
                
            Text(categoryName).font(.footnote).foregroundColor(.white).padding()
                
                
            }.background(self.getButtonColor()).cornerRadius(20).shadow(radius: 10)
    }
}
    
}

struct CategoryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButtonView(presentor: nil, text: "Breweries")
    }
}
