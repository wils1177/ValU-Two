//
//  DetailedParentCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/29/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI


struct DetailedParentCategoryCard: View {
    
    
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
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3){
            
            HStack(alignment: .center){
                BudgetSectionIconLarge(color: self.color, icon: self.icon, size: 60, cornerRadius: 20)
                Spacer()
                
                VStack(alignment: .trailing){
                    Text("Spending").foregroundColor(Color(.lightText)).font(.system(size: 18, design: .rounded)).fontWeight(.semibold)
                    HStack(alignment: .top){
                        Text(CommonUtils.makeMoneyString(number: Int(self.spent))).foregroundColor(Color(.white)).font(.system(size: 23, design: .rounded)).fontWeight(.semibold)
                        
                        Text("/ " + CommonUtils.makeMoneyString(number: Int(self.limit))).foregroundColor(Color(.white)).font(.system(size: 23, design: .rounded)).fontWeight(.semibold)
                    }
                    
                    
                }
                
                
                
                
            }.padding(.bottom, 45)
            
            HStack(alignment: .bottom, spacing: 0.0){
                Text(self.name).font(.system(size: 28, design: .rounded)).bold().foregroundColor(.white).lineLimit(1)
                Spacer()
                
                if self.percentageSpent >= 1.0{
                    HStack{
                        Image(systemName: "exclamationmark.triangle.fill" ).foregroundColor(Color(.white)).font(Font.system(size: 27, weight: .semibold)).padding(.trailing, 5)
                        //Text("Over Budget").font(.headline).bold().foregroundColor(.white).lineLimit(1).padding(.trailing, 10)
                    }.padding(.trailing)
                    
                }
                
            }.padding(.bottom, 10)
            
            ProgressBarView(percentage: CGFloat(self.percentageSpent), color: Color(.white), backgroundColor: self.colorTertiary).padding(.trailing, 5).padding(.bottom, 5)
            
        }.padding(.horizontal, 15).padding(.vertical,15)
        
        .background(LinearGradient(gradient: Gradient(colors: [self.colorSeconday, self.color]), startPoint: .top, endPoint: .bottom)).cornerRadius(20)
    }
}


