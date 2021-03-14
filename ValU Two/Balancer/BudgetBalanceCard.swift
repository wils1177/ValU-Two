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
    
    init(budgetSection: BudgetSection, coordinator: SetSpendingLimitDelegate, viewModel: BudgetBalancerPresentor){
        self.budgetSection = budgetSection
        self.coordinator = coordinator
        self.viewModel = viewModel
        
        self.color = colorMap[Int(budgetSection.colorCode)]
        self.colorSeconday = Color(colorMapUIKit[Int(budgetSection.colorCode)].lighter()!)
        self.colorTertiary = Color(colorMapUIKit[Int(budgetSection.colorCode)].darker()!)
    }
    
    
    
    var card : some View{
        
        

            HStack{
                BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)], icon: self.budgetSection.icon ?? "calendar", size: CGFloat(45))
                
                HStack(){
                    //Text(self.icon).font(.system(size: 22)).bold()
                    Text(self.budgetSection.name ?? "unknown").font(.system(size: 18, design: .rounded)).bold().foregroundColor(Color(.white)).lineLimit(1)
                    Spacer()

                }

                    Spacer()
                
                           
                Text(CommonUtils.makeMoneyString(number: Int(self.budgetSection.getLimit()))).font(.system(size: 21, design: .rounded)).foregroundColor(Color(.white)).bold()
                Image(systemName: "chevron.right").foregroundColor(Color(.white)).font(Font.system(.headline).bold()).padding(.leading, 5).padding(.trailing, 5)
            }.padding(11).background(LinearGradient(gradient: Gradient(colors: [self.colorSeconday, self.color]), startPoint: .top, endPoint: .bottom)).cornerRadius(20).shadow(radius: 0)
                
        
    }
    
    
    var body: some View {
        
        Button(action: {
            self.coordinator.showCategoryDetail(budgetSection: self.budgetSection, viewModel: self.viewModel)
        }) {
            self.card.padding(.vertical, 2)
        }.buttonStyle(PlainButtonStyle())
    }
}
