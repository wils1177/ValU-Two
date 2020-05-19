//
//  CategoryCardListView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryCardListView<Model>: View where Model: CategoryListViewModel {
    
    var viewModel : Model
    var categories : [SpendingCategory]

    init(viewModel: Model, categories: [SpendingCategory]){
        self.viewModel = viewModel
        self.categories = categories
    }
    

    
    
    var body: some View {
        
        VStack{
            
            ForEach(self.categories, id: \.self){ category in
                CategoryCardView(presentor: self.viewModel, category: category)
            }
            
            
            
        }
        
        
        
    }
}
