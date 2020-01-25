//
//  CurrentlySelectedCategoriesView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI



struct CurrentlySelectedCategoriesView: HasButtonRows, View {
    
    
    var buttonArray =  [[CategoryButton]]()
    
    
    @ObservedObject var viewModel : EditCategoryViewModel
    
    init(viewModel : EditCategoryViewModel){
        self.viewModel = viewModel
        self.buttonArray = generateButtonArray(buttonList: self.viewModel.selectedButtons)
    }
    

    
    var body: some View {
        
        
        
        VStack(alignment: .leading){
            
            
            
            HStack{
                Text("Current Categories").font(.title)
                Spacer()
                
                
            }.padding(.leading)
            
            
            ForEach(self.buttonArray, id: \.self){ buttonRow in
                
                HStack{
                    ForEach(buttonRow, id: \.self){ button in
                        CategoryButtonView(presentor: self.viewModel, button: button).padding(.top)
                    }
                }
                
            }
            
            }.padding().padding(.leading)
            
    }
}





