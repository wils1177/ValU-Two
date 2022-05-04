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
    var coordinator : SetSpendingLimitDelegate
    var viewModel : BudgetBalancerPresentor
    
    var color : Color
    var colorSeconday : Color
    var colorTertiary : Color
    
    @State var showingDeleteAlert = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    init(budgetSection: BudgetSection, coordinator: SetSpendingLimitDelegate, viewModel: BudgetBalancerPresentor){
        self.budgetSection = budgetSection
        self.coordinator = coordinator
        self.viewModel = viewModel
        
        self.color = colorMap[Int(budgetSection.colorCode)]
        self.colorSeconday = Color(colorMapUIKit[Int(budgetSection.colorCode)].lighter()!)
        self.colorTertiary = Color(colorMapUIKit[Int(budgetSection.colorCode)].darker()!)
    }
    
    
    
  
    
    var row: some View{
        
            HStack{
                BudgetSectionIconLarge(color: self.color, icon: self.budgetSection.icon ?? "book", size: 35).padding(.trailing, 5)
                VStack(alignment: .leading, spacing: 0){
                    
                    Text(self.budgetSection.name ?? "no name").font(.system(size: 18, design: .rounded)).fontWeight(.semibold).lineLimit(1).foregroundColor((colorScheme == .dark) ? Color.white : Color.black)
                    //Text(String(self.budgetSection.getBudgetCategories().count) + " Categories").font(.system(size: 15, design: .rounded)).fontWeight(.semibold).foregroundColor(Color(.lightGray))
                    //Text(self.viewModel.getDisplayPercentageForSection(section: self.budgetSection)).font(.system(size: 15, design: .rounded)).fontWeight(.semibold).foregroundColor(color)
                    
                    
                    
                }.padding(.trailing)
                Spacer()
                VStack(alignment: .trailing){
                    
                    //Text(CommonUtils.makeMoneyString(number: Int(self.budgetSection.getLimit()))).font(.system(size: 18, design: .rounded)).fontWeight(.bold)
                    
                    
                    NavigationBarTextButton(text: CommonUtils.makeMoneyString(number: Int(self.budgetSection.getLimit())), color: color)
                    
                   // Text(self.viewModel.getDisplayPercentageForSection(section: self.budgetSection)).font(.system(size: 15, design: .rounded)).fontWeight(.semibold).foregroundColor(Color(.lightGray))
                    
                }
                
                Image(systemName: "chevron.right").font(.system(size: 15, design: .rounded)).foregroundColor(Color(.lightGray))
                
            }
           
            
            
            
            
        
    }
    

    
    
    var body: some View {
        
        Button(action: {
            self.coordinator.showCategoryDetail(budgetSection: self.budgetSection, viewModel: self.viewModel)
        }) {
            //self.cardGrid
            self.row
        }
            
    }
}
