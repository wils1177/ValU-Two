//
//  BalanceDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BalanceDetailView: View {
    
    @ObservedObject var budgetSection : BudgetSection
    @ObservedObject var service : BalanceParentService
    var coordinator : BudgetEditableCoordinator
    
    
    init(budgetSection : BudgetSection, service : BalanceParentService, coordinator: BudgetEditableCoordinator){
        self.coordinator = coordinator
        self.budgetSection = budgetSection
        self.service = service
        

    }
    
    func move(from source: IndexSet, to destination: Int) {
        print("move it move it")
        
        let source = source.first!
        
        let items = self.budgetSection.getBudgetCategories()
        
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
        self.budgetSection.objectWillChange.send()
        
    }
    
    func delete(at offsets: IndexSet) {
        
        print("delete triggered")
        
        let source = offsets.first!
        let categories = self.budgetSection.getBudgetCategories()
        let toDelete = categories[source]
        self.service.deleteCategory(id: toDelete.id!)

    }
    
    var newCategoryButton : some View{
        Button(action: {
            
            self.coordinator.showNewCategoryView(budgetSection: self.budgetSection)
        }) {
            Image(systemName: "plus.circle.fill").font(.system(size: 28, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary)
            Text("Add Category").foregroundColor(AppTheme().themeColorPrimary).bold()
        }.buttonStyle(PlainButtonStyle())
    }
    
    
    var topCard: some View{
        VStack(alignment: .center){


            HStack(){
                Spacer()
                VStack{
                    Text("").font(.system(size: 22)).bold()
                    //Text(self.spendingCategory.name!).font(.system(size: 17)).foregroundColor(Color(.black)).bold()
                }
                
                Spacer()

            }.padding(.top)

            
            HStack{
                Spacer()
                Text("$" + String(Int(self.service.getParentLimit()))).font(.system(size: 42)).bold()
                Spacer()
            }
            HStack{
                Spacer()
                Text("Budgeted").font(.headline).foregroundColor(Color(.lightGray))
                Spacer()
            }.padding(.bottom).padding(.bottom)
            
            

                   
               }//.background(Color(.white)).cornerRadius(15)
    }
    
    
    
    var sectionHeader : some View{
        VStack{
            HStack{
                BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)] as! Color, icon: self.budgetSection.icon!, size: 40)
                Text("Budget Detail").font(.system(size: 22)).bold().padding(.leading, 5)
                Spacer()
            }.padding(.top)
            

        }
    }
    
    
    var emptyState : some View{
        
        VStack{
            HStack{
                Spacer()
                Text("No Categories Yet").foregroundColor(Color(.gray)).bold().padding(.vertical, 20)
                Spacer()
            }
            
            
            /*
            Button(action: {
                
                self.coordinator.showNewCategoryView(budgetSection: self.budgetSection)
            }) {
                HStack{
                    Spacer()
                    newCategoryButton
                    Spacer()
                }.padding(10).background(Color(.white)).cornerRadius(15)
            }.buttonStyle(PlainButtonStyle())
            */
            
            
            
        }
        
    }
    
    
    
    
    var body: some View {
        
        
        List{
            
            topCard.padding(.vertical)
                           
                       
            
            if ((self.budgetSection.getBudgetCategories()).count > 0){
                //self.sectionHeader
                    ForEach((self.budgetSection.getBudgetCategories()), id: \.self) { child in
                            VStack{
                                BudgetDetailCard(budgetCategory: child, parentService: self.service, coordinator: self.coordinator).padding(.vertical, 10).padding(.horizontal, 5)
                            }.listRowInsets(EdgeInsets())
                        
                        
                    }.onDelete(perform: delete).onMove(perform: move)
                
            }
            else{
                emptyState
            }
            
            BalanceDetailHelpCard(coordinator: self.coordinator)
            
            
            
                
                
        }
        
        
        .listStyle(SidebarListStyle())
            .navigationBarTitle(Text(self.budgetSection.name!)).navigationBarItems(trailing: Button(action: {
                self.coordinator.goBack()
                    }){
                        
                    HStack{
                                                
                        ColoredActionButton(text: "Done")
                    }
            })
        .toolbar {
            
            ToolbarItem(placement: .bottomBar) {
                newCategoryButton
                
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



struct BalanceDetailHelpCard: View {
    
    var coordinator: BudgetEditableCoordinator
    
    var body: some View{
        VStack(alignment: .center){
            Text("Need help with what to budget?").font(.headline).bold()
            Text("Try looking at some of your previous transactions.").multilineTextAlignment(.center).font(.subheadline).padding(.vertical, 2)
            
            Button(action: {
                // What to perform
                self.coordinator.showFullTransactionsList()
            }) {
                HStack{
                    Spacer()
                    Text("View Transactrions").foregroundColor(Color(.white)).bold()
                    Spacer()
                }.padding(10).background(AppTheme().themeColorPrimary).cornerRadius(15)
            }.buttonStyle(PlainButtonStyle())
            
            
            
        }.padding().background(Color(.white)).cornerRadius(15).shadow(radius: 5)
    }
}
