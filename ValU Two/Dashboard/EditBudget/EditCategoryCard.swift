//
//  EditCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/3/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditCategoryCard<ViewModel>: View where ViewModel: CategoryListViewModel {
    

    var category : SpendingCategory
    var subCategories : [SpendingCategory]
    
    var viewModel : ViewModel
    

    
    init(category: SpendingCategory, viewModel : ViewModel){
        self.category = category
        self.subCategories = category.subSpendingCategories?.allObjects as! [SpendingCategory]
        self.viewModel = viewModel
    }
    
    
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 11),
            GridItem(.flexible(), spacing: 11),
        GridItem(.flexible(), spacing: 11)
        ]
    
    var body: some View {
        
        VStack(spacing: 0.0){
                 
                 
            HStack(spacing: 0.0){
                   
                Text(self.category.name!).font(.system(size: 20)).bold()
                   Spacer()
                  
            }.padding(.bottom)
            
            LazyVGrid(      columns: columns,
                            alignment: .center,
                            spacing: 10,
                            pinnedViews: [.sectionHeaders, .sectionFooters]
            ){
                
                ForEach(self.subCategories, id: \.self){entry in
                    
                    EditCategoryRowView(category: entry, viewModel: self.viewModel)
                                    
                }
            }
                          


                 }
    }
}


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


