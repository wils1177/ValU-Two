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
            Text("Budgets").font(.system(size: 21)).foregroundColor(Color(.black)).bold()
            Spacer()
            newSectionButton
            //EditButton()
        }.padding(.top, 10).padding(.bottom, 5).padding(.horizontal)
        
    }
    
    func delete(at offsets: IndexSet) {
        
        print("delete triggered")
        
        for index in Array(offsets){
            //let id = viewModel.budgetSections[index].id!
            let sections = viewModel.budget.getBudgetSections()
            let id = sections[index].id!
            self.viewModel.deleteBudgetSection(id: id)
        }
    }
    
    
    func move(from source: IndexSet, to destination: Int) {
        print("move it move it")
    }
      
      var body: some View {
        VStack{
            
            List{
                             
                        SpendingLimitSummaryView(viewModel: self.viewModel).cornerRadius(15).padding(.bottom, 20).padding(.top)
                        
                            
                        Section(header: self.budgetsHeader){
                            
                        
                        //budgetsHeader.padding(.horizontal)
                           ForEach(self.budget.getBudgetSections(), id: \.self) { section in
                                VStack(spacing: 0){
                                    
                                        BudgetBalanceCard(service: BalanceParentService(budgetSection: section), budgetSection: section, coordinator: self.viewModel.coordinator!)
                                    
            
                                }
                                        

                            }.onDelete(perform: delete).onMove(perform: move)
                            
                        
                        
                        }
                        
                
                      
                            
                        
                    }.listStyle(GroupedListStyle())
            HStack{
                EditButton().padding(.leading).padding(.bottom)
                Spacer()
            }
        
        }
        
        

    }
           
      
}


