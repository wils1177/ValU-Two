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
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
        )
    }
    
    var body: some View {
        VStack{
            self.indicator.padding(.top)
            HStack{
                Spacer()
                Button(action: {
                    self.isShowingAddCategory.toggle()
                }){
                    Text("Done").padding(.horizontal)
                }.buttonStyle(BorderlessButtonStyle())
            }
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
                
                
                
                ScrollView(.vertical, content: {
                    
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
                    
                    
                    CategoryCardListView(viewModel: self.viewModel.viewData!.budgetCategoriesPresentor)
                })
                
                
            }
            
            
        }
    }
}


