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
    
    func getDisplayArray(categories: [SpendingCategory]) -> [[SpendingCategory]]{
        return categories.chunked(into: 2)
    }
    
    var body: some View {
        VStack(spacing: 0.0){
                 
                 
            HStack(spacing: 0.0){
                   
                Text("Unbudgeted Categories").font(.system(size: 20)).bold()
                   Spacer()
                   //CategoryButtonView(text: "Add Section")
            }

                 
                   
            //Divider().padding(.horizontal)
                
            VStack(spacing: 0){
                ForEach(self.getDisplayArray(categories: self.categories), id: \.self){pair in
                    
                    VStack{
                        GeometryReader{g in
                            HStack{
                                    ForEach(pair, id: \.self){entry in
                                        
                                        HStack{

                                            EditCategoryRowView(category: entry, viewModel: self.viewModel).frame(width: (g.size.width / 2))
                                            
                                            if pair.count == 1{
                                                Spacer().frame(width: (g.size.width / 2) + 9)
                                            }
                                        }.padding(.bottom, 15)
                                        
                                        
                                        
                                    }
                                
                                
                            }
                        }
                        
                        
                    }.padding(.vertical, 24)
                    
                        
                }
            }
             
                                       


                 }
    }
}
