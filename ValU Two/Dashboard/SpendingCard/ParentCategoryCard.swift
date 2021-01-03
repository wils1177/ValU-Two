//
//  ParentCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ParentCategoryCard: View {
    
    @ObservedObject var budgetSection : BudgetSection
    var color : Color
    var colorSeconday : Color
    var colorTertiary : Color
    
    init(budgetSection: BudgetSection){
        self.budgetSection = budgetSection
        self.color = colorMap[Int(budgetSection.colorCode)] as! Color
        self.colorSeconday = colorMapSecondary[Int(budgetSection.colorCode)]
        self.colorTertiary = colorMapTertiaruy[Int(budgetSection.colorCode)]
        
    }
    
    
    var body: some View {
        
        
        VStack(alignment: .leading){
            
            HStack{
                BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)] as! Color, icon: self.budgetSection.icon!, size: 40)
                Spacer()
                SpendingSummary(spent: Float(self.budgetSection.getSpent()), limit: Float(self.budgetSection.getLimit()))
            }.padding(.bottom, 15)
            
            HStack{
                Text(self.budgetSection.name!).font(.subheadline).bold().foregroundColor(.white).lineLimit(1)
                Spacer()
            }
            
            ProgressBarView(percentage: CGFloat(self.budgetSection.getPercentageSpent()), color: Color(.white), backgroundColor: self.colorTertiary).padding(.trailing, 5).padding(.bottom, 5)
            
        }.padding(12)
        
        .background(LinearGradient(gradient: Gradient(colors: [self.colorSeconday, self.color]), startPoint: .top, endPoint: .bottom)).cornerRadius(20)
        

    }
}


