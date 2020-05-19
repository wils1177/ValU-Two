//
//  SuggestionEntryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SuggestionEntryView: View {
    
    var viewModel : SuggestedCategoryPresentor
    var category : SpendingCategory
    
    init(viewModel : SuggestedCategoryPresentor, category: SpendingCategory ){
        self.viewModel = viewModel
        self.category = category
    }
    
    var body: some View {
        HStack{
            
            
            CategoryButtonView(category: self.category)
            
            
            
        }
    }
}


