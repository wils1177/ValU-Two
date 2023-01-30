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
           
        
      }
    
    var newSectionButton : some View{
        Button(action: {
            self.viewModel.showNewSectionView()
        }) {
            HStack{
                Image(systemName: "plus.circle.fill").font(.system(size: 22, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary)
                Text("New Budget").font(.system(size: 18, weight: .regular, design: .rounded)).foregroundColor(AppTheme().themeColorPrimary).bold()
                
            }
            
        }.buttonStyle(PlainButtonStyle())
    }
    
    
    
    var headerText: some View{
        Text("Budgets").font(.system(size: 18, weight: .bold, design: .rounded))
    }
      
      var body: some View {
        
            
            List{
                
                
                    
                    
                
                SpendingLimitSummaryView(viewModel: self.viewModel).listRowSeparator(.hidden).listRowBackground(Color.clear).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).padding(.horizontal, 10).padding(.top)
                
                
                    
                    
                Section(header: headerText){
                    BalanceBudgetCardList(viewModel: self.viewModel, sections: self.budget.getBudgetSections())//.listRowSeparator(.hidden)
                }//.padding(.top, 20).padding(.horizontal, 26)
                
                
            
                
                            
                        
                
                                                
                
                      
                            
                        
                    }
            
            
        
        
        
        
        
            .background(Color(.systemGroupedBackground))
        .navigationBarTitle("Set Budget", displayMode: .large).navigationBarItems(trailing:
            
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
        
                                                                                    .alert(isPresented: $showNothingBudgetedAlert) {
                                                                                        Alert(title: Text("Budget is Still Empty"), message: Text("Set some categories for your budget first!"), dismissButton: .default(Text("Got it!")))
                                                                            }
        
        
        
    )
        
        
        
        .toolbar {
            
            ToolbarItem(placement: .bottomBar) {
                HStack{
                    newSectionButton
                    Spacer()
                    EditButton()
                }
                
                
                
            }
            
            

        }
        
        

    }
           
      
}


struct BalanceBudgetCardList : View {
    
    var viewModel : BudgetBalancerPresentor
    @ObservedObject var budget: Budget
    var sections : [BudgetSection]
    
    @State var showingDeleteAlert = false
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 13),
            GridItem(.flexible(), spacing: 13)
        ]
    
    init(viewModel: BudgetBalancerPresentor, sections: [BudgetSection]){
        self.viewModel = viewModel
        self.sections = sections
        self.budget = viewModel.budget
    }
    
    @State var toDelete : BudgetSection?
    
    func deleteAttempt(section: BudgetSection){
        self.toDelete = section
        self.showingDeleteAlert.toggle()
    }
    
    
    func delete(section: BudgetSection) {
        
        print("delete triggered")
        
        
        self.viewModel.deleteBudgetSection(section: section)
            
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
        
        //VStack{
        /*
            HStack{
                Text("Budget Groups").font(.system(size: 22, design: .rounded)).bold()
                Spacer()
            }.padding(.leading, 5)
         */
            
            ForEach(self.sections, id: \.self) { section in
                                
                BudgetBalanceCard(budgetSection: section, coordinator: self.viewModel.coordinator!, viewModel: self.viewModel).padding(.vertical, 2)
              
                    .swipeActions(allowsFullSwipe: true) {
                                                Button {
                                                    self.viewModel.editSection(section: section)
                                                } label: {
                                                    Label("Edit", systemImage: "pencil")
                                                }
                                                .tint(.blue)

                                                
                                            }
                
                
                    .swipeActions(allowsFullSwipe: true) {
                                                Button {
                                                    
                                                    deleteAttempt(section: section)
                                                    
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                                .tint(.red)

                                                
                                            }
                
                    
        
                            

            }.onMove(perform: move)
             
     
            .alert(isPresented:self.$showingDeleteAlert) {
                Alert(title: Text("Are you sure you want to delete this budget?"), message: Text("All associated data will be deleted"), primaryButton: .destructive(Text("Delete")) {
                    self.delete(section: self.toDelete!)
                }, secondaryButton: .cancel())
            }
    }
}


