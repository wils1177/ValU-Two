//
//  NewBudgetCategoryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/28/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditBudgetCategoriesView: View {
    
    var budgetSection : BudgetSection
    @ObservedObject var viewModel : AddCategoriesViewModel
    @State var isShowingNewBudgetCategory = false
    
    var coordinator : BudgetEditableCoordinator?
    
    init(budgetSection: BudgetSection, viewModel: AddCategoriesViewModel){
        self.budgetSection = budgetSection
        self.viewModel = viewModel
        
     
    }
    
    var newCategoryButton: some View{
            
            Button(action: {
                self.isShowingNewBudgetCategory.toggle()
            }) {
                HStack{
                    Spacer()
                    Image(systemName: "scribble").font(.system(size: 21, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary)
                    Text("Create Custom Category").foregroundColor(AppTheme().themeColorPrimary).fontWeight(.semibold)
                    Spacer()
                }
                
            }.buttonStyle(PlainButtonStyle()).padding().background(Color(.systemGroupedBackground)).cornerRadius(15).padding()
                        
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                VStack{
                    newCategoryButton.padding(.vertical).listRowBackground(Color(.systemGroupedBackground))
  
                        ForEach(self.viewModel.parentSpendingCategories, id: \.self){ category in
                            EditCategoryCard(category: category, viewModel: self.viewModel).padding(.bottom).padding(.horizontal).padding(.bottom)
                        }.listRowBackground(Color(.systemGroupedBackground))
                }
                
                
            }
            //.listStyle(SidebarListStyle())
            .navigationBarTitle("Add Categories", displayMode: .inline).navigationBarItems(
                leading: Button(action: {
                            self.coordinator?.dismissPresented()
                        }){
                        ZStack{
                            
                            Text("Cancel")
                        }
                }
                    ,trailing: Button(action: {
                        self.viewModel.submit()
                        self.coordinator?.dismissPresented()
                    }){
                    ZStack{
                        
                        Text("Add")
                    }
            })
        }.sheet(isPresented: self.$isShowingNewBudgetCategory){
            CreateCustomBudgetCategoryView(viewModel: self.viewModel)
        }
        
        
        
        
    }
}

