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
    
    var newCategoryButton : some View{
        Button(action: {
            
            self.coordinator.showNewCategoryView(budgetSection: self.budgetSection)
        }) {
            Image(systemName: "plus.circle.fill").font(.system(size: 28, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary)
        }
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
                BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)], icon: self.budgetSection.icon!, size: 40)
                Text("Budget Detail").font(.system(size: 22)).bold().padding(.leading, 5)
                Spacer()
                newCategoryButton.padding(.trailing)
                }.padding(.vertical)
            

        }
    }
    
    
    
    
    var body: some View {
        
        
        List{
            
            topCard.padding(.top)
                           
                       
            
           
                
            Section(header: sectionHeader){
                ForEach(self.budgetSection.budgetCategories?.allObjects as! [BudgetCategory], id: \.self) { child in
                        VStack{
                            BudgetDetailCard(budgetCategory: child, parentService: self.service).padding(.vertical, 5)
                        }
                    
                    
                }
            }
            
                
                
        }
        
        
        .listStyle(GroupedListStyle())
            .navigationBarTitle(Text(self.budgetSection.name!)).navigationBarItems(trailing: Button(action: {
                self.coordinator.goBack()
                    }){
                    ZStack{
                        
                        Text("Confirm")
                    }
            })
    
    }
}



