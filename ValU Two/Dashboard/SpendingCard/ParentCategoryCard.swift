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
    var section: BudgetSection?
    
    
    init(budgetSection: BudgetSection){
        self.section = budgetSection
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
    
    var colorDesign : some View{
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
        
            .background(LinearGradient(gradient: Gradient(colors: [self.colorSeconday, self.color]), startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(23)
    }
    
    
    var whiteDesign : some View{
        VStack(alignment: .leading){
            
            HStack(alignment: .top){
                BudgetSectionIconLarge(color: self.color, icon: self.icon, size: 40)
                Spacer()
                Text(CommonUtils.makeMoneyString(number: Int(self.spent))).foregroundColor(Color(.black)).font(.system(size: 18, design: .rounded)).fontWeight(.bold)
            }.padding(.bottom, 15)
            
            HStack{
                Text(self.name).font(.system(size: 15, design: .rounded)).bold().foregroundColor(.black).lineLimit(1)
                Spacer()
                if percentageSpent >= 1.0 {
                    Image(systemName: "exclamationmark.triangle.fill" ).foregroundColor(Color(.black)).font(Font.system(size: 14, weight: .semibold)).padding(.trailing, 10)
                }
            }
            
            ProgressBarView(percentage: CGFloat(getDisplayPercent()), color: self.color, backgroundColor: self.color.opacity(0.3)).padding(.trailing, 5).padding(.bottom, 5)
            
        }.padding(12)
        
            .background(color.opacity(0.2)).cornerRadius(23)
    }
    
    var rowDesign: some View{
        Section(){
            
            VStack{
                HStack{
                    BudgetSectionIconLarge(color: self.color, icon: self.icon, size: 38).padding(.leading)
                    VStack(alignment: .leading, spacing: 7){
                        
                            Text(self.name).font(.system(size: 17, design: .rounded)).fontWeight(.bold)
                                 
                        
                        
                        
                        ProgressBarView(percentage: self.getDisplayPercent(), color: self.color.opacity(0.7), backgroundColor: self.color.opacity(0.3))
                    }.padding(.horizontal, 5).padding(.trailing)
                    Spacer()
                    VStack(alignment: .trailing){
                        
                        Text(CommonUtils.makeMoneyString(number: Int(self.spent))).font(.system(size: 18, design: .rounded)).fontWeight(.bold)
                        
                        
                    }.padding(.trailing, 25)
                    
                }
                .padding(.vertical, 12).background(self.color.opacity(0.2))
                
                
                VStack{
                    
                    if self.section != nil{
                        ForEach(self.section!.getBudgetCategories(), id: \.self) { category in
                                
                            HStack{
                                Text(category.spendingCategory!.icon!).font(.system(size: 19, design: .rounded)).fontWeight(.bold)
                                Text(category.spendingCategory!.name!).font(.system(size: 17, design: .rounded)).fontWeight(.semibold)
                                Spacer()
                                Text("\(CommonUtils.makeMoneyString(number: Int(category.getAmountSpent())))").font(.system(size: 17, design: .rounded)).fontWeight(.semibold)
                                Text("/ \(CommonUtils.makeMoneyString(number: Int(category.limit)))").font(.system(size: 17, design: .rounded)).foregroundColor(Color(.lightGray)).fontWeight(.semibold)
                            }.padding(.vertical, 10)
                            
                            if category.id != self.section?.getBudgetCategories().last!.id{
                                Divider().padding(.leading, 25).foregroundColor(Color.clear)
                            }
                            
                            
                        }
                    }
                    
                    
                    
                    
                }.padding(.horizontal)
                
            }.background(self.color.opacity(0.06)).cornerRadius(25).listRowSeparator(.hidden)
            
        }.listRowBackground(Color.clear)
        
        
        
    }

    
    var body: some View {
        
        
        
        self.rowDesign

    }
}


