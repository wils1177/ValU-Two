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
                        ["📺 ", "📷", "📒", "📦", "⛏️"],
                        ["📺 ", "📷", "📒", "📦", "⛏️"]]
    
    var viewModel : AddCategoriesViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                
                
                VStack{
                    Text(self.icons[self.selectedRow][self.selectedColumn]).font(.system(size: 75)).padding(.top, 30).padding(.bottom, 5)
                    

                    
                    TextField("Name", text: self.$nameText).font(Font.system(size: 23, weight: .semibold)) .multilineTextAlignment(.center).frame(height: 28, alignment: .center).padding().background(Color(.secondarySystemBackground)).cornerRadius(20).padding()
                }.padding(.bottom, 30)
                
                HStack{
                    Text("Choose an Icon!").font(.title3).bold()
                    Spacer()
                }.padding(.horizontal)

                EmojiSelectionGridView(icons: self.$icons, selectedRow: self.$selectedRow, selectedColumn: self.$selectedColumn).padding(5).background(Color(.systemGray6)).cornerRadius(20)
                    .padding(.horizontal)
            }.navigationBarTitle("New Category", displayMode: .inline).navigationBarItems(
                         
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    self.presentationMode.wrappedValue.dismiss()
                        }){
                        ZStack{
                            
                            NavigationBarTextButton(text: "Cancel")
                        }
                }
                    ,trailing: Button(action: {
                        self.viewModel.createCustomSpendingCategory(icon: self.icons[self.selectedRow][self.selectedColumn],  name: self.nameText)
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                    ZStack{
                        
                        NavigationBarTextButton(text: "Add")
                    }
            })
        }
            
            
        }
        
    
}


