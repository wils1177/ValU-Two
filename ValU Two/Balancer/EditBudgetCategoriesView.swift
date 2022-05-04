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
                    //Spacer()
                    Image(systemName: "plus.circle.fill").font(.system(size: 19, weight: .regular, design: .rounded)).foregroundColor(AppTheme().themeColorPrimary).padding(.horizontal, 8)
                    Text("Create Custom Category").font(.system(size: 15, weight: .regular, design: .rounded)).fontWeight(.bold).foregroundColor(AppTheme().themeColorPrimary)
                    Spacer()
                }
                
            }.buttonStyle(PlainButtonStyle()).padding(10).padding(.vertical, 3).background(Color(.tertiarySystemBackground)).cornerRadius(10).padding(.horizontal).padding(.top)
                        
    }
    
    var recurringToggle : some View{
        HStack{
            Image(systemName: "clock.arrow.circlepath").foregroundColor(globalAppTheme.themeColorPrimary).padding(.horizontal, 8)
            Toggle(isOn: withAnimation{$viewModel.willBeRecurring}) {
                Text("Category is Recurring ").font(.system(size: 15, design: .rounded)).fontWeight(.semibold)
            }.padding(.trailing, 5)
        }
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                VStack{
                    newCategoryButton.padding(.top)
                    
                    recurringToggle.padding(10).background(Color(.tertiarySystemBackground)).cornerRadius(10).padding(.horizontal).padding(.vertical)
  
                        ForEach(self.viewModel.parentSpendingCategories, id: \.self){ category in
                            EditCategoryCard(category: category, viewModel: self.viewModel).padding(.bottom).padding(.horizontal).padding(.bottom)
                        }
                }
                
                
            }
            .background(Color(.systemGroupedBackground))
            //.listStyle(SidebarListStyle())
            .navigationBarTitle("Add Categories", displayMode: .inline).navigationBarItems(
                leading: Button(action: {
                            self.coordinator?.dismissPresented()
                        }){
                        ZStack{
                            
                            NavigationBarTextButton(text: "Cancel")
                        }
                }
                    ,trailing: Button(action: {
                        self.viewModel.submit()
                        self.coordinator?.dismissPresented()
                    }){
                    ZStack{
                        
                        NavigationBarTextButton(text: "Add")
                    }
            })
        }.sheet(isPresented: self.$isShowingNewBudgetCategory){
            CreateCustomBudgetCategoryView(submitCallBack: self.viewModel.createCustomSpendingCategory)
        }
        
        
        
        
    }
}

