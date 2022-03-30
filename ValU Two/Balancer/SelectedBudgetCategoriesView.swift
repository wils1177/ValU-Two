//
//  SelectedBudgetCategoriesView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/6/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SelectedBudgetCategoriesView: View {
    
    var spendingCategories : [SpendingCategory]
    var viewModel : AddCategoriesViewModel
    
    init(spendingCategories: [SpendingCategory], viewModel: AddCategoriesViewModel){
        self.spendingCategories = spendingCategories
        self.viewModel = viewModel
    }
    
    func getDisplayArray(categories: [SpendingCategory]) -> [[SpendingCategory]]{
        return [[SpendingCategory]]()
    }
    
    var title: some View{
        HStack(spacing: 0.0){
               
            Text("Selected").font(.system(size: 20)).bold()
               Spacer()
               //CategoryButtonView(text: "Add Section")

            Button(action: {
                // What to perform
            }) {
                // How the button looks like
                Text("Clear").padding(.trailing)
            }
        }.padding(.bottom)
    }
    
    var body: some View {
        VStack(spacing: 0.0){
        
            title
        
        
            VStack(spacing: 0){
                ForEach(self.getDisplayArray(categories: self.spendingCategories), id: \.self){pair in
                    
                    VStack{
                        GeometryReader{g in
                            HStack{
                                    ForEach(pair, id: \.self){entry in
                                        
                                        HStack{

                                            EditCategoryRowView(category: entry, viewModel: self.viewModel).frame(width: (g.size.width / 2))
                                            
                                            if pair.count == 1{
                                                Spacer().frame(width: (g.size.width / 2) + 10)
                                            }
                                        }.padding(.bottom, 15)
                                        
                                        
                                        
                                    }
                                
                                
                            }
                        }
                        
                        
                    }.padding(.vertical, 23)

                }
            }
        }.animation(.easeInOut(duration: 0.3))
    }
}

