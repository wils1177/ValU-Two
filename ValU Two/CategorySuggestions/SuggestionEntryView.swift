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
    var viewData : SuggestedCategoryViewData
    
    init(viewModel : SuggestedCategoryPresentor, viewData: SuggestedCategoryViewData ){
        self.viewModel = viewModel
        self.viewData = viewData
    }
    
    var body: some View {
        HStack{
            
            
            CategoryButtonView(presentor: self.viewModel, button: self.viewData.categoryButton)
            
            Spacer()
            
            Text(viewData.amountSpent).font(.headline)
            
            
        }
    }
}


