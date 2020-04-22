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

    init(viewModel: Model){
        self.viewModel = viewModel
    }
    

    
    
    var body: some View {
        
        VStack{
            
            ForEach(self.viewModel.viewData, id: \.self){ cardData in
                CategoryCardView(presentor: self.viewModel, viewData: cardData)
            }
            
            
            
        }
        
        
        
    }
}
