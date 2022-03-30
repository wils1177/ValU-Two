//
//  EditCategoryRowView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/3/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditCategoryRowView<ViewModel>: View where ViewModel: CategoryListViewModel  {
    
    @ObservedObject var category : SpendingCategory
    @ObservedObject var viewModel : ViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    func getButtonColor() -> Color {
        if self.viewModel.isSelected(name: category.name!){
            
            return AppTheme().themeColorPrimary
        }
        else{
            return .clear
        }
    }
    
    func getTextColor() -> Color {
        if self.viewModel.isSelected(name: category.name!){
            
            return AppTheme().themeColorPrimary
        }
        else{
            return (colorScheme == .light ? Color.black : Color.white)
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
    
    func getBackgroundColor() -> Color {
        if self.viewModel.isSelected(name: category.name!){
            return AppTheme().themeColorPrimary.opacity(0.2)
        }
        else{
            return Color(.tertiarySystemBackground)
        }
    }
    

    
    init(category: SpendingCategory, viewModel : ViewModel ){
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
                    Spacer()
                    VStack(alignment: .center){
                        Text(category.icon!).font(.system(size: 35)).padding(.bottom, 5)
                        
                        HStack{
                            Text(category.name!).font(.system(size: 13)).fontWeight(.semibold).lineLimit(2).multilineTextAlignment(.center).foregroundColor(self.getTextColor())
                            //Image(systemName: "checkmark").foregroundColor(self.getButtonColor()).imageScale(.small).padding(.trailing, 5)
                        }
                        
                        
                    }.padding(.vertical, 5)
                    Spacer()
                }
                .padding(5).frame(height: 110).background(self.getBackgroundColor()).cornerRadius(23)
        }.buttonStyle(PlainButtonStyle())
    }
}

