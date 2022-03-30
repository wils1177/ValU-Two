//
//  EditCategoriesView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditCategoriesView: View {
    
    @ObservedObject var viewModel : EditCategoryViewModel
    
    @State var saveRule = true
    
    init(viewModel : EditCategoryViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                        
                         
                         VStack{

                             
                                HStack{
                                   Image(systemName: "bookmark.fill").padding(.horizontal, 8)
                                    Toggle(isOn: $viewModel.saveRule) {
                                        Text("Remember for Merchant")
                                    }.padding(.trailing, 5)
                                }.padding(10).background(Color(.tertiarySystemBackground)).cornerRadius(10).padding(.horizontal).padding(.top)
                               
                               
                            
                            
                            HStack{
                                Text("When selected, ValU will remeber your choices for future transactions from the same merchant.").font(.footnote).foregroundColor(Color(.lightGray))
                            }.padding(.horizontal, 10).padding(.bottom)
                             
                             
                            
                            if self.viewModel.budgetSections.count != 0{
                                ForEach(self.viewModel.budgetSections, id: \.self){ section in
                                    EditCategoryCardBudgetSection(section: section, viewModel: self.viewModel).padding(.bottom).padding(.bottom)
                                }.padding(.horizontal)
                                
                                if self.viewModel.unassignedBudgetCategories.count > 0{
                                    EditCategoryCardUnassignedView(categories: self.viewModel.unassignedBudgetCategories, viewModel: self.viewModel).padding(.bottom).padding(.bottom).padding(.horizontal)
                                }
                                
                            }
                            else{
                                ForEach(self.viewModel.spendingCategories, id: \.self){ category in
                                    EditCategoryCard(category: category, viewModel: self.viewModel).padding(.bottom).padding(.bottom)
                                }.padding(.horizontal)
                            }
                            
                            
                            
                            
                            
                         }.listStyle(SidebarListStyle())
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Change Category", displayMode: .large)
            .navigationBarItems(
                
                leading:
                
                    Button(action: {
                                     self.viewModel.dismiss()
                                 }){
                
                        NavigationBarTextButton(text: "Cancel")
                                             
                }
                
                ,trailing: Button(action: {
                                 self.viewModel.submit()
                             }){
            
                    NavigationBarTextButton(text: "Done")
                                         
            })
            
        }
        
            
        
        
                
        
        
    }
    
}



//struct EditCategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
 //       EditCategoriesView(viewModel: nil)
 //   }
//}
