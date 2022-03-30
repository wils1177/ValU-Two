//
//  EditCategoryCardBudgetSection.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditCategoryCardBudgetSection<ViewModel>: View where ViewModel: CategoryListViewModel {
    

    var budgetSection : BudgetSection
    var categories : [BudgetCategory]
    
    var viewModel : ViewModel
    

    
    init(section: BudgetSection, viewModel : ViewModel){
        self.budgetSection = section
        self.categories = budgetSection.getBudgetCategories()
        self.viewModel = viewModel
    }
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 11),
            GridItem(.flexible(), spacing: 11),
        GridItem(.flexible(), spacing: 11)
        ]
    
    
    
    var title : some View{
        
        HStack(spacing: 0.0){
            
            BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)] as! Color, icon: self.budgetSection.icon!, size: 35).padding(.trailing, 10)
            Text(self.budgetSection.name!).foregroundColor(colorMap[Int(self.budgetSection.colorCode)] as! Color).font(.system(size: 22, design: .rounded)).bold()
               Spacer()
               //CategoryButtonView(text: "Add Section")
        }

        
    }
    
    var body: some View {
        VStack(spacing: 0.0){
                 
                 
            self.title.padding(.bottom, 20)
                 
                   
            LazyVGrid(      columns: columns,
                            alignment: .center,
                            spacing: 10,
                            pinnedViews: [.sectionHeaders, .sectionFooters]
            ){
                
                ForEach(self.categories, id: \.self){entry in
                    EditCategoryRowView(category: entry.spendingCategory!, viewModel: self.viewModel)
                    
                    
                        
                }
                
            }
                
                
            
             
                                       


                 }
    }
}
