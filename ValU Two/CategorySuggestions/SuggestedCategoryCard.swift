//
//  SuggestedCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SuggestedCategoryCard: View {
    
    var viewModel : SuggestedCategoryPresentor
    
    init(viewModel : SuggestedCategoryPresentor){
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Suggestions").font(.title).fontWeight(.bold)
                Spacer()
            }.padding(.leading)
            HStack{
                Text("Based on your previous month's spending.")
                Spacer()
            }.padding(.leading)
            
            
            Divider()
            
            HStack{
                Text("Category").font(.headline).foregroundColor(Color(.gray))
                Spacer()
                Text("Spent Last Month").font(.headline).foregroundColor(Color(.gray))
            }.padding(.leading).padding(.trailing).padding(.top)
            
            List(self.viewModel.spendingCategories, id: \.self){ category in
    
                SuggestionEntryView(viewModel: self.viewModel, category: category).padding(.leading).padding(.trailing)
            }

            
            
            
            Spacer()
        }.padding()
    }
}


