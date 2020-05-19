//
//  EditCategoryRowView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/3/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditCategoryRowView: View {
    
    @ObservedObject var category : SpendingCategory
    @ObservedObject var viewModel : EditCategoryViewModel
    
    func getButtonColor() -> Color {
        if self.viewModel.isSelected(name: category.name!){
            
            return .green
        }
        else{
            return .clear
        }
    }
    
    func getTextColor() -> Color {
        if self.viewModel.isSelected(name: category.name!){
            
            return .green
        }
        else{
            return .black
        }
    }
    
    func getButtonIconName() -> String {
        if self.viewModel.isSelected(name: category.name!){
            
            return "checkmark.circle.fill"
        }
        else{
            return "plus.circle.fill"
        }
    }
    

    
    init(category: SpendingCategory, viewModel : EditCategoryViewModel ){
        self.category = category
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button(action: {
            
            if self.viewModel.isSelected(name: self.category.name!){
                print("unselecting")
                self.viewModel.deSelectedCategoryName(name: self.category.name!)
            }
            else{
                
                self.viewModel.selectedCategoryName(name: self.category.name!)
            }
                
            }){
                HStack{
                    Text(category.icon!).font(.headline).padding(.leading, 8).padding(.trailing, 6)
                    
                    Text(category.name!).font(.callout).fontWeight(.semibold).lineLimit(1).foregroundColor(self.getTextColor())
                    Spacer()
                    Image(systemName: "checkmark").foregroundColor(self.getButtonColor()).imageScale(.small).padding(.trailing, 5)
                    
                }.padding(5).padding(.vertical, 9).background(Color(.white)).cornerRadius(10).overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(self.getButtonColor(), lineWidth: 3)
                    ).padding(.horizontal, 2)
        }.buttonStyle(PlainButtonStyle())
    }
}

