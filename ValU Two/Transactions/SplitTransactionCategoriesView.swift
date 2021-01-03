//
//  SplitTransactionCategoriesView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SplitTransactionCategoriesView: View {
    
    @ObservedObject var viewModel : SplitTransactionCategoryViewModel
    
    
    init(viewModel : SplitTransactionCategoryViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                        
                         
                         VStack{
                            
                            Text("Select other categories you'd like to split your transaction between.").foregroundColor(Color(.gray)).padding(.horizontal).padding(.vertical)

                     
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
            }.navigationBarTitle("Split Cateogries", displayMode: .large)
            .navigationBarItems(
                
                leading:
                
                    Button(action: {
                                     self.viewModel.dismiss()
                                 }){
                
                        Text("Cancel").font(.subheadline).bold().foregroundColor(AppTheme().themeColorPrimary).padding(7)
                                             
                }
                
                ,trailing: Button(action: {
                                 self.viewModel.submit()
                             }){
            
                Text("Done").font(.subheadline).bold().foregroundColor(AppTheme().themeColorPrimary).padding(7)
                                         
            })
            
        }
        
            
        
        
                
        
        
    }
}


