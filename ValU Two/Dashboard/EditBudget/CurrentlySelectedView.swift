//
//  CurrentlySelectedView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/3/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CurrentlySelectedView: View {
    
    @ObservedObject var transaction : Transaction
    var categories : [CategoryMatch]
    @ObservedObject var viewModel : EditCategoryViewModel
    
    init(transaction: Transaction, viewModel: EditCategoryViewModel){
        self.transaction = transaction
        self.categories = transaction.categoryMatches!.allObjects as! [CategoryMatch]
        self.viewModel = viewModel
    }
    
    func getCategories(transaction: Transaction) -> [SpendingCategory]{
        var categories = [SpendingCategory]()
        for match in transaction.categoryMatches!.allObjects as! [CategoryMatch]{
            categories.append(match.spendingCategory!)
        }
        return categories
    }
    
    func getDisplayArray(categories: [SpendingCategory]) -> [[SpendingCategory]]{
        return categories.chunked(into: 2)
    }
    
    var body: some View {
        
        VStack(spacing: 0.0){
        
            HStack(spacing: 0.0){
                   
                Text("Selected").font(.system(size: 20)).bold()
                   Spacer()
                   //CategoryButtonView(text: "Add Section")

                Button(action: {
                    // What to perform
                    self.viewModel.clearSelected()
                }) {
                    // How the button looks like
                    Text("Clear").padding(.trailing)
                }
            }.padding(.bottom)
        
        
            VStack(spacing: 0){
                ForEach(self.getDisplayArray(categories: self.getCategories(transaction: self.transaction)), id: \.self){pair in
                    
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


