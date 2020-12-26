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
    
    func getDisplayArray(categories: [SpendingCategory]) -> [[SpendingCategory]]{
        return categories.chunked(into: 2)
    }
    
    var body: some View {
        VStack(spacing: 0.0){
                 
                 
            HStack(spacing: 0.0){
                   
                Text(self.category.name!).font(.system(size: 20)).bold()
                   Spacer()
                   //CategoryButtonView(text: "Add Section")
            }

                 
                   
            //Divider().padding(.horizontal)
                    
            VStack(spacing: 0){
                ForEach(self.getDisplayArray(categories: self.subCategories), id: \.self){pair in
                    
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


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


