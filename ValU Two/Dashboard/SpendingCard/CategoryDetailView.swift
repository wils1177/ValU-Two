//
//  CategoryDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryDetailView: View {
    
    var sectionModel : BudgetDetailViewModel
    var coordinator : BudgetsTabCoordinator
    
    @ObservedObject var section: BudgetSection
    
    init(sectionModel: BudgetDetailViewModel, coordinator: BudgetsTabCoordinator){
        self.sectionModel = sectionModel
        self.coordinator = coordinator
        self.section = sectionModel.section
    }
    
    var transactionsSection : some View {
            ForEach(self.sectionModel.categories, id: \.self) { category in
                
                CategoryDetailTransactionsSection(category: category, coordinator: self.coordinator).padding(.bottom)
                
        }
        
    
    }


    var body: some View {
        ScrollView{
            LazyVStack{
                DetailedParentCategoryCard(budgetSection: self.sectionModel.section).padding(.top).padding(.horizontal).shadow(radius: 15).padding(.bottom, 35)
                
                
                transactionsSection.listRowInsets(EdgeInsets()).padding(.horizontal, 5)
            }
            

  
            }
        
        .navigationBarItems(
            trailing: Button(action: {
                self.coordinator.showEditBudgetSectionIndividually(section: self.sectionModel.section)
            }){
            
                NavigationBarTextButton(text: "Edit", color: colorMap[Int(sectionModel.section.colorCode)])
    })
            

        }
}



