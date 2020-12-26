//
//  BalancerBodyView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BalancerBodyView: View {
    
    @ObservedObject var viewModel : BudgetBalancerPresentor
    @ObservedObject var budget : Budget
    
    @State private var editMode = EditMode.inactive
      
    init(viewModel: BudgetBalancerPresentor, budget: Budget){
          
          self.viewModel = viewModel
        self.budget = budget
           
      }
    
    var newSectionButton : some View{
        Button(action: {
            self.viewModel.showNewSectionView()
        }) {
            Image(systemName: "plus.circle.fill").font(.system(size: 28, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary)
        }.buttonStyle(PlainButtonStyle())
    }
    
    var budgetsHeader : some View{
        HStack{
            Text("Budgets").font(.system(size: 23)).foregroundColor(Color(.black)).bold()
            Spacer()
            
            
            
            newSectionButton
            //EditButton()
        }.padding(.top, 10)
        
    }
    
    func delete(at offsets: IndexSet) {
        
        print("delete triggered")
        
        let source = offsets.first!
        let sections = viewModel.budget.getBudgetSections()
        let toDelete = sections[source]
        self.viewModel.deleteBudgetSection(section: toDelete)
        

    
    }
    
    
    func move(from source: IndexSet, to destination: Int) {
        print("move it move it")
        
        let source = source.first!
        
        let items = self.budget.getBudgetSections()
        
        if source < destination {
            var startIndex = source + 1
            let endIndex = destination - 1
            var startOrder = items[source].order
            while startIndex <= endIndex {
                items[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            items[source].order = startOrder
        }
        else if destination < source{
            var startIndex = destination
            let endIndex = source - 1
            var startOrder = items[destination].order + 1
            let newOrder = items[destination].order
            while startIndex <= endIndex {
                items[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            items[source].order = newOrder
        }
        
        DataManager().saveDatabase()
        
    }
      
      var body: some View {
        VStack{
            
            List{
                             
                        SpendingLimitSummaryView(viewModel: self.viewModel).cornerRadius(15).padding(.bottom, 10).padding(.top)
                        
                            

                        budgetsHeader.padding(.horizontal)
                           ForEach(self.budget.getBudgetSections(), id: \.self) { section in
                                VStack(spacing: 0){
                                    
                                        BudgetBalanceCard(service: BalanceParentService(budgetSection: section), budgetSection: section, coordinator: self.viewModel.coordinator!)
                                    
            
                                }.listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                        

                            }.onDelete(perform: delete).onMove(perform: move)
                            
                        
                        
                                                
                
                      
                            
                        
                    }.listStyle(SidebarListStyle())
            
        
        }
        
        

    }
           
      
}


