//
//  BudgetBalanceCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/10/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetBalanceCard: View {
    
    @ObservedObject var budgetSection : BudgetSection
    @ObservedObject var service : BalanceParentService
    var coordinator : SetSpendingLimitDelegate
    
    init(service: BalanceParentService, budgetSection: BudgetSection, coordinator: SetSpendingLimitDelegate){
        self.budgetSection = budgetSection
        self.service = BalanceParentService(budgetSection: budgetSection)
        self.coordinator = coordinator
    }
    
    
    
    var card : some View{
        
        

            HStack{
                BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)], icon: self.budgetSection.icon!, size: CGFloat(45))
                CategoryHeader(name: self.budgetSection.name!).padding(.leading)

                    Spacer()

                           
                Text("$" + String(Int(self.service.getParentLimit()))).font(.system(size: 21)).bold().foregroundColor(Color(.black))
                Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold()).padding(.leading, 5).padding(.trailing, 5)
            }.padding(10).background(Color(.white)).cornerRadius(15)
                
                       
                       
                       
                   
            
            
            
        
        
        
    }
    
    
    var body: some View {
        
        Button(action: {
            self.coordinator.showCategoryDetail(budgetSection: self.budgetSection, service: self.service)
        }) {
            self.card.padding(.vertical, 2)
        }.buttonStyle(BorderlessButtonStyle())
    }
}
