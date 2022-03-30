//
//  CategoryDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryDetailView: View {
    
    var coordinator : BudgetsTabCoordinator
    
    @ObservedObject var section: BudgetSection
    
    init(section: BudgetSection, coordinator: BudgetsTabCoordinator){
        self.coordinator = coordinator
        self.section = section
    }
    
    


    var body: some View {
        List{
            
        
                DetailedParentCategoryCard(budgetSection: self.section).padding(.top).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowBackground(Color.clear)//.shadow(radius: 15)
            
            
                
            ForEach(self.section.getBudgetCategories(), id: \.self) { category in
                    
                Section(header: CategorySectionHeader(limit: category.limit, spent: category.getAmountSpent(), icon: category.spendingCategory!.icon!, name: category.spendingCategory!.name!, color: colorMap[Int(category.budgetSection!.colorCode)])){
                    
                    CategoryDetailTransactionsSection(category: category, coordinator: self.coordinator)
                }
                
                    
                    
            }
            
  
        }
        
        .navigationBarItems(
            trailing: Button(action: {
                self.coordinator.showEditBudgetSectionIndividually(section: self.section)
            }){
            
                NavigationBarTextButton(text: "Edit", color: colorMap[Int(section.colorCode)])
    })
            

        }
}

struct CategorySectionHeader: View{
    
    var limit : Double
    var spent : Double
    var icon : String
    var name : String
    var color: Color
    
    var body: some View{
        HStack(spacing: 0){
            
            VStack(alignment: .leading){
                Text(self.name).font(.system(size: 16, design: .rounded)).bold().lineLimit(1)
                
            }
            
            
                
                Spacer()
            
            Text("\(Text(CommonUtils.makeMoneyString(number: spent)).font(.system(size: 16, design: .rounded)).foregroundColor(self.color).bold()) / \(Text(CommonUtils.makeMoneyString(number: limit)))").font(.system(size: 16, design: .rounded)).bold().foregroundColor(Color(.gray)).lineLimit(1)
                
            
                
            }
    }
    
}



