//
//  CreateCustomBudgetCategoryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/6/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CreateCustomBudgetCategoryView: View {
    
    @State var nameText = ""
    
    @State var selectedRow = 0
    @State var selectedColumn = 0
    
    @State var icons = [["🥳", "😎", "🙌", "🏂", "🏂"], ["💪", "🤩", "🍊", "🏋️‍♂️", "🏂"], ["🍣", "🍫", "🍶", "🤽‍♂️", "🏂"], ["💪", "🤩", "🍊", "🏋️‍♂️", "🏂"]]
    
    var viewModel : AddCategoriesViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Text(self.icons[self.selectedRow][self.selectedColumn]).font(.system(size: 60))
                    
                    TextField("Category Name", text: self.$nameText).font(Font.system(size: 20, weight: .semibold)).frame(width: 300, height: 30, alignment: .center).padding().background(Color(.systemGroupedBackground)).cornerRadius(10)
                }.padding(.top, 40)
                

                EmojiSelectionGridView(icons: self.$icons, selectedRow: self.$selectedRow, selectedColumn: self.$selectedColumn)
                    .padding().padding(.top, 30)
            }.navigationBarTitle("New Category", displayMode: .inline).navigationBarItems(
                         
                leading: Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                        ZStack{
                            
                            Text("Cancel")
                        }
                }
                    ,trailing: Button(action: {
                        self.viewModel.createCustomSpendingCategory(icon: self.icons[self.selectedRow][self.selectedColumn],  name: self.nameText)
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                    ZStack{
                        
                        Text("Add")
                    }
            })
        }
            
            
        }
        
    
}


