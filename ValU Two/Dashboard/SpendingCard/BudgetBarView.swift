//
//  Option2.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/6/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetBarView: View {
    var barHeight = 55
    var iconText : String
    var categoryName : String
    //var amountSpent = "$550"
    var limitText = "/ $650"
    var percentage = 0.35
    var hue : Double = 0.35
    
   @ObservedObject var spendingCategory : SpendingCategory
    
    init(spendingCategory: SpendingCategory){
        self.spendingCategory = spendingCategory
        self.iconText = spendingCategory.icon!
        self.categoryName = spendingCategory.name!
        
        let limit = spendingCategory.limit
        let amount = spendingCategory.spent
        
        let percentage = getPercentage(amount: amount, limit: limit)
        
        self.hue = getHue(percentage: percentage)
        self.limitText = self.getLimitText(limit: limit)
        
        
    }

    func getAmountSpent(amount: Float) -> String{
        return "$" + String(Int(amount))
    }
    
    func getLimitText(limit: Float) -> String{
        return"/ $" + String(Int(limit))
    }
    
    func getPercentage(amount: Float, limit: Float) -> Double{
        
        if (amount / limit) < 0.10 || limit == 0.0{
            return 0.10
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
            return Double(0.321)
        }
        else if percentage < 0.75{
            return Double(0.321)
        }
        else if percentage < 1.0 && percentage > 0.7{
            return Double(0.321)
        }
        else{
            return Double(0.0)
        }
    }
    
    

    

    
    var background: some View{
        RoundedRectangle(cornerRadius: 20).frame(height: CGFloat(self.barHeight)).foregroundColor(Color(.quaternarySystemFill))

    }
    
    var progressBar: some View{
        GeometryReader{ g in
            HStack{
                RoundedRectangle(cornerRadius: 20).frame(width: CGFloat(g.size.width) * CGFloat(self.getPercentage(amount: self.spendingCategory.spent, limit: self.spendingCategory.limit)), height: CGFloat(self.barHeight)).foregroundColor(colorMap[Int(self.spendingCategory.colorCode)])
                Spacer()
            }
            
        }
    }
    
    var description: some View{
        HStack{
            Text(self.iconText).font(.system(size: 25)).shadow(radius: 2)
            Text(self.categoryName).font(.headline).padding(.leading, 5)
            Spacer()
            Text(getAmountSpent(amount: self.spendingCategory.getAmountSpent())).bold().font(.headline)
            Text(self.limitText).foregroundColor(Color(.lightGray)).font(.headline)
        }.padding(.horizontal, 15)
    }
    
    var body: some View {
        
            ZStack(){
            
            background
                
            progressBar.offset(x:2)
            
            
                description
                
            
            
            }.padding(.horizontal, 3)
        
        
            
        
    }
}
