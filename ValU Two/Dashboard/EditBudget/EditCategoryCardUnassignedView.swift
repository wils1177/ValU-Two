//
//  EditCategoryCardUnassignedView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditCategoryCardUnassignedView<ViewModel>: View where ViewModel: CategoryListViewModel {
    

    var categories : [SpendingCategory]
    
    var viewModel : ViewModel
    

    
    init(categories: [SpendingCategory], viewModel : ViewModel){
        self.categories = categories
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
                   
                Text("Unbudgeted Categories").font(.system(size: 20)).bold()
                   Spacer()
                   //CategoryButtonView(text: "Add Section")
            }.padding(.bottom, 20)

                 
                   
            LazyVGrid(      columns: columns,
                            alignment: .center,
                            spacing: 10,
                            pinnedViews: [.sectionHeaders, .sectionFooters]
            ){
                ForEach(self.categories, id: \.self){entry in
                    EditCategoryRowView(category: entry, viewModel: self.viewModel)
                }
            }
                
            
                    
                        
                
            }
             
                                       


                 
    }
}
