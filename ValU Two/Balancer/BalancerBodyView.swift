//
//  BalancerBodyView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BalancerBodyView: View {
    
    var viewModel : BudgetBalancerPresentor
    @ObservedObject var budget : Budget
    
    @State private var editMode = EditMode.inactive
    
    @State var showNothingBudgetedAlert = false
    
    @State var showOverBudgetAlert = false
      
    init(viewModel: BudgetBalancerPresentor, budget: Budget){
          
          self.viewModel = viewModel
        self.budget = budget
           
        UITableView.appearance().separatorStyle = .none
        
        UITableView.appearance().backgroundColor = .clear
      }
    
    var newSectionButton : some View{
        Button(action: {
            self.viewModel.showNewSectionView()
        }) {
            HStack{
                Image(systemName: "plus.circle.fill").font(.system(size: 28, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary)
                Text("New Budget").foregroundColor(AppTheme().themeColorPrimary).bold()
            }
            
        }.buttonStyle(PlainButtonStyle())
    }
    
    
    
    
      
      var body: some View {
        VStack{
            
            List{
                
                VStack{
                    //Divider().padding(.leading)
                    SectionHeader(title: "Summary", image: "house").padding(.horizontal).padding(.top, 10)
                    
                                 
                    SpendingLimitSummaryView(viewModel: self.viewModel).padding(.top, 15)
                    
                    Divider().padding(.leading)

                    SectionHeader(title: "Budgets", image: "creditcard").padding(.horizontal).padding(.top, 10)
                }
                
                
                        
                BalanceBudgetCardList(viewModel: self.viewModel, sections: self.budget.getBudgetSections()).padding(.horizontal)
                            
                        
                Spacer().padding(.top)
                                                
                
                      
                            
                        
                    }.listStyle(SidebarListStyle()).padding(.horizontal, -20)
            
            
        
        }
        
        .alert(isPresented: $showNothingBudgetedAlert) {
                    Alert(title: Text("Budget is Still Empty"), message: Text("Set some categories for your budget first!"), dismissButton: .default(Text("Got it!")))
        }
        
       
        .navigationBarTitle("Set Budgets", displayMode: .large).navigationBarItems(trailing:
            
            HStack{
                
                

                Button(action: {
                    print("user requested to continue from budget balancing")
                    let result = self.viewModel.requestToContinue()
                    print(result)
                    if result == BudgetContinueResponse.CanContinue{
                        self.viewModel.coordinator?.finishedSettingLimits()
                    }
                    else if result == BudgetContinueResponse.OverBudget{
                        self.showOverBudgetAlert = true
                    }
                    else if result == BudgetContinueResponse.BudgetEmpty{
                        print("budget empty")
                        self.showNothingBudgetedAlert = true
                    }
                    
                    
                }){
                    
                    NavigationBarTextButton(text: "Done")
                    
                }
            }
                                                                                   
            .alert(isPresented:$showOverBudgetAlert) {
                Alert(title: Text("Over Budget!"), message: Text("You've budgeted more than you've set for your income!"), dismissButton: .default(Text("I'll fix it!")))
                }
        
        
        
        
        
    )
        
        
        
        .toolbar {
            
            ToolbarItem(placement: .bottomBar) {
                newSectionButton
                
            }
            
            ToolbarItem(placement: .bottomBar) {
                HStack{
                    Spacer()
                    EditButton().foregroundColor(AppTheme().themeColorPrimary)
                }
                
            }
            

        }
        
        

    }
           
      
}


struct BalanceBudgetCardList : View {
    
    var viewModel : BudgetBalancerPresentor
    @ObservedObject var budget: Budget
    var sections : [BudgetSection]
    
    @State var showDeleteAlert = false
    
    init(viewModel: BudgetBalancerPresentor, sections: [BudgetSection]){
        self.viewModel = viewModel
        self.sections = sections
        self.budget = viewModel.budget
    }
    
    
    
    func delete(at offsets: IndexSet) {
        
        print("delete triggered")
        
        let source = offsets.first!
        let toDelete = self.sections[source]
        self.viewModel.deleteBudgetSection(section: toDelete)
            
    }
    
    
    func move(from source: IndexSet, to destination: Int) {
        print("move it move it")
        
        let source = source.first!
        
        let items = self.sections
        
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
        self.viewModel.budget.objectWillChange.send()
    }
    
    var body: some View{
        ForEach(self.sections, id: \.self) { section in
                        VStack(spacing: 0){
                            
                            BudgetBalanceCard(budgetSection: section, coordinator: self.viewModel.coordinator!, viewModel: self.viewModel).padding(.vertical, 5)
                            
    
                        }.listRowInsets(EdgeInsets())

        }.onDelete(perform: delete).onMove(perform: move)
    }
}


