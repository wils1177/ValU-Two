//
//  ParentCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ParentCategoryCard: View {
    
    var color : Color
    var colorSeconday : Color
    var colorTertiary : Color
    var icon : String
    
    var spent: Float
    var limit : Float
    var name: String
    var percentageSpent: Double
    
    
    init(budgetSection: BudgetSection){
        self.color = colorMap[Int(budgetSection.colorCode)]
        self.colorSeconday = Color(colorMapUIKit[Int(budgetSection.colorCode)].lighter()!)
        self.colorTertiary = Color(colorMapUIKit[Int(budgetSection.colorCode)].darker()!)
        self.icon = budgetSection.icon!
        self.spent = Float(budgetSection.getSpent())
        self.limit = Float(budgetSection.getLimit())
        self.name = budgetSection.name!
        self.percentageSpent = budgetSection.getPercentageSpent()
    }
    
    init(color: Color, colorSecondary: Color, colorTertiary: Color, icon: String, spent: Float, limit: Float, name: String, percentageSpent: Double){
        self.color = color
        self.colorSeconday = colorSecondary
        self.colorTertiary = colorTertiary
        self.icon = icon
        self.spent = spent
        self.limit = limit
        self.name = name
        self.percentageSpent = percentageSpent
    }
    
    func getDisplayPercent() -> Double{
        if self.percentageSpent < 0.1{
            return 0.1
        }
        else{
            return self.percentageSpent
        }
    }

    
    var body: some View {
        
        
        VStack(alignment: .leading){
            
            HStack(alignment: .top){
                BudgetSectionIconLarge(color: self.color, icon: self.icon, size: 40)
                Spacer()
                Text(CommonUtils.makeMoneyString(number: Int(self.spent))).foregroundColor(Color(.white)).font(.system(size: 18, design: .rounded)).fontWeight(.bold)
            }.padding(.bottom, 15)
            
            HStack{
                Text(self.name).font(.system(size: 15, design: .rounded)).bold().foregroundColor(.white).lineLimit(1)
                Spacer()
                if percentageSpent >= 1.0 {
                    Image(systemName: "exclamationmark.triangle.fill" ).foregroundColor(Color(.white)).font(Font.system(size: 14, weight: .semibold)).padding(.trailing, 10)
                }
            }
            
            ProgressBarView(percentage: CGFloat(getDisplayPercent()), color: Color(.white), backgroundColor: self.colorTertiary).padding(.trailing, 5).padding(.bottom, 5)
            
        }.padding(12)
        
        .background(LinearGradient(gradient: Gradient(colors: [self.colorSeconday, self.color]), startPoint: .top, endPoint: .bottom)).cornerRadius(20)
        

    }
}


