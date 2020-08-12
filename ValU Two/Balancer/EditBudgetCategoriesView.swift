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
                    Image(systemName: "plus.circle.fill").font(.system(size: 21, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary)
                    Text("Create Category").foregroundColor(AppTheme().themeColorPrimary).fontWeight(.semibold)
                    Spacer()
                }
                
            }.buttonStyle(PlainButtonStyle()).padding().background(Color(.white)).cornerRadius(15)
                        
    }
    
    var body: some View {
        NavigationView{
            List{
                
                newCategoryButton.padding(.vertical)
                
                //SelectedBudgetCategoriesView(spendingCategories: self.viewModel.getAllCurrentlySelected(), viewModel: self.viewModel).padding(.vertical)
                    
                
                
                    ForEach(self.viewModel.parentSpendingCategories, id: \.self){ category in
                        EditCategoryCard(category: category, viewModel: self.viewModel)
                    }
                
            }.navigationBarTitle("Add Categories", displayMode: .inline).navigationBarItems(
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

