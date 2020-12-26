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
        self.color = colorMap[Int(budgetSection.colorCode)]
        self.colorSeconday = colorMapSecondary[Int(budgetSection.colorCode)]
        self.colorTertiary = colorMapTertiaruy[Int(budgetSection.colorCode)]
        
    }
    
    
    var body: some View {
        
        
        VStack(alignment: .leading){
            
            HStack{
                BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)], icon: self.budgetSection.icon!)
                Spacer()
                SpendingSummary(spent: Float(self.budgetSection.getSpent()), limit: Float(self.budgetSection.getLimit()))
            }.padding(.bottom, 15)
            
            HStack{
                Text(self.budgetSection.name!).font(.title2).bold().foregroundColor(.white)
                Spacer()
            }
            
            ProgressBarView(percentage: CGFloat(self.budgetSection.getPercentageSpent()), color: Color(.white), backgroundColor: self.colorTertiary).padding(.trailing, 5).padding(.bottom, 5)
            
        }.padding()
        
        .background(LinearGradient(gradient: Gradient(colors: [self.colorSeconday, self.color]), startPoint: .top, endPoint: .bottom)).cornerRadius(15)
        

    }
}


