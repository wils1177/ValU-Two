//
//  Option2.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/6/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetBarView: View {
    var barHeight = 60
    var iconText : String
    var categoryName : String
    var amountSpent = "$550"
    var limitText = "/ $650"
    var percentage = 0.35
    var hue : Double = 0.35
    
    var spendingCategory : SpendingCategory?
    
    init(spendingCategory: SpendingCategory){
        self.spendingCategory = spendingCategory
        self.iconText = spendingCategory.icon!
        self.categoryName = spendingCategory.name!
        
        let limit = spendingCategory.limit
        let amount = spendingCategory.spent
        
        let percentage = getPercentage(amount: amount, limit: limit)
        
        self.percentage = percentage
        self.hue = getHue(percentage: percentage)
        self.amountSpent = getAmountSpent(amount: amount)
        self.limitText = self.getLimitText(limit: limit)
        
        
    }
    
    init(iconText: String, categoryName: String, amountSpent: String, limitText: String, percentage: Double){
        
        self.iconText = iconText
        self.categoryName = categoryName
        self.amountSpent = amountSpent
        self.limitText = limitText
        self.percentage = percentage
        
        self.hue = getHue(percentage: percentage)
        
    }
    
    func getAmountSpent(amount: Float) -> String{
        return "$" + String(Int(amount))
    }
    
    func getLimitText(limit: Float) -> String{
        return"/ $" + String(Int(limit))
    }
    
    func getPercentage(amount: Float, limit: Float) -> Double{
        
        if limit == 0.0{
            return 0.15
        }
        if amount / limit > 1.0{
            
            return 1.0
        }
        else if amount / limit < 0.0{
            return 0.0
        }
        
        
        return Double(amount / limit)
    }
    
    func getHue(percentage: Double) -> Double{
        if self.spendingCategory == nil{
            return Double(0.255)
        }
        else if percentage < 0.75{
            return Double(0.255)
        }
        else if percentage < 1.0 && percentage > 0.7{
            return Double(0.167)
        }
        else{
            return Double(0.0)
        }
    }
    
    

    

    
    var background: some View{
        RoundedRectangle(cornerRadius: 20).frame(height: CGFloat(self.barHeight)).foregroundColor(Color(hue: hue, saturation: 0.05, brightness: 0.95))

    }
    
    var progressBar: some View{
        GeometryReader{ g in
            HStack{
                RoundedRectangle(cornerRadius: 20).frame(width: CGFloat(g.size.width) * CGFloat(self.percentage), height: CGFloat(self.barHeight)).foregroundColor(Color(hue: self.hue, saturation: 0.35, brightness: 1.0))
                Spacer()
            }
            
        }
    }
    
    var description: some View{
        HStack{
            Text(self.iconText).font(.title)
            Text(self.categoryName).font(.headline).padding(.leading, 5)
            Spacer()
            Text(self.amountSpent).bold().font(.headline)
            Text(self.limitText).foregroundColor(Color(.lightGray)).font(.headline)
        }.padding(.horizontal, 15)
    }
    
    var body: some View {
            ZStack(){
                
                background.shadow(radius: 2)
                    
                    progressBar
                
                
                    description
                    
                
                
                }.padding(.horizontal, 3)
        
        
    }
}
