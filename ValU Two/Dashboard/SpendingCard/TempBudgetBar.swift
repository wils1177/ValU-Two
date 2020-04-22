//
//  TempBudgetBar.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/18/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TempBudgetBar: View {
    
    var spendingCategory : SpendingCategory?
    
    var iconText : String
    var categoryName : String
    var amountSpent = "$550"
    var limitText = "/ $650"
    var percentage = 0.35
    
    init(spendingCategory: SpendingCategory){
        self.spendingCategory = spendingCategory
        self.iconText = spendingCategory.icon!
        self.categoryName = spendingCategory.name!
        
        let limit = spendingCategory.limit
        let amount = spendingCategory.spent
        
        let percentage = getPercentage(amount: amount, limit: limit)
        
        self.percentage = percentage
        self.amountSpent = getAmountSpent(amount: amount)
        self.limitText = self.getLimitText(limit: limit)
        
        
    }
    
    init(iconText: String, categoryName: String, amountSpent: String, limitText: String, percentage: Double){
        
        self.iconText = iconText
        self.categoryName = categoryName
        self.amountSpent = amountSpent
        self.limitText = limitText
        self.percentage = percentage
        
        
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
    
    var iconView : some View{
        VStack{
            Text(self.iconText).font(.title).padding(7)
        }.background(Color(.white)).cornerRadius(15).shadow(radius: 1)
        
    }
    
    var body: some View {
        
        HStack{
           iconView
            VStack{
                HStack{
                    Text(self.categoryName).bold().padding(.leading)
                    Spacer()
                    Text(self.amountSpent)
                    Text(self.limitText).foregroundColor(Color(.gray)).padding(.trailing)
                }
                HStack{
                    ProgressBarView(percentage: CGFloat(self.percentage), color: .white).padding(.leading)
                    Spacer()
                }
                
            }
            
            
        }.padding(.horizontal, 5)
        
    }
}


