//
//  CategoryPickerBody.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryPickerBody: View {
    
    @State private var pickerSelection = 0
    var viewModel : CategoryPickerPresentor
    @Binding var isShowingAddCategory : Bool
    

    
    var body: some View {
        
        NavigationView{
            List{

                Picker("", selection: $pickerSelection) {
                    
                  Text("Suggestions").tag(0)
                  Text("All Categories").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                if self.pickerSelection == 0{
                    SuggestedCategoryCard(viewModel: viewModel.viewData!.suggestedCategoryPresentor)
                }
                else{
                    
                    
                    
                        
                        VStack{
                            HStack{
                                Text("All Categories").font(.title).fontWeight(.bold)
                                Spacer()
                            }.padding(.leading)
                            HStack{
                                Text("Select from an exaustive list of categories")
                                Spacer()
                            }.padding(.leading)
                            Divider()
                        }.padding()
                        
                        
                        CategoryCardListView(viewModel: self.viewModel.viewData!.budgetCategoriesPresentor, categories: self.viewModel.viewData!.budgetCategoriesPresentor.spendingCategories)
                    
                    
                    
                }
                
                
            }.navigationBarTitle("Choose Category", displayMode: .large)
            .navigationBarItems( trailing: Button(action: {
                                 //self.viewModel.submit()
                                self.isShowingAddCategory.toggle()
                             }){
            
                                 Text("Done").font(.subheadline).foregroundColor(.black).padding(7)
                                         
                             })
        }
        
        
    }
}


