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
    
    @State var icons = [["🥳", "🍏", "🍴", "🏂", "🐕"],
                        ["🐙", "🍿", "🎟️", "⚾", "🎹"],
                        ["🏠", "🚆", "🚗", "🚲", "🛳️"],
                        ["🗿", "🎉", "💎", "☎️", "🔌"],
                        ["📺 ", "📷", "📒", "📦", "⛏️"]]
    
    var viewModel : AddCategoriesViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                
                
                VStack{
                    Text(self.icons[self.selectedRow][self.selectedColumn]).font(.system(size: 70)).padding(.vertical, 25)
                    
                    
                    HStack{
                        Text("Name").font(.title3).bold()
                        Spacer()
                    }.padding(.horizontal)
                    
                    TextField("Category Name", text: self.$nameText).font(Font.system(size: 20, weight: .semibold)).frame(height: 30, alignment: .center).padding().background(Color(.systemGroupedBackground)).cornerRadius(10).padding()
                }.padding(.top, 40)
                
                HStack{
                    Text("Icon").font(.title3).bold()
                    Spacer()
                }.padding(.horizontal).padding(.top, 15)

                EmojiSelectionGridView(icons: self.$icons, selectedRow: self.$selectedRow, selectedColumn: self.$selectedColumn).padding(5).background(Color(.systemGroupedBackground)).cornerRadius(20)
                    .padding()
            }.navigationBarTitle("New Category", displayMode: .inline).navigationBarItems(
                         
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
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


