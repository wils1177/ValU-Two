//
//  ChildCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ChildCategoryCard: View {
    
    @ObservedObject var budgetCategory : BudgetCategory
    
    func getPercentage() -> Double{
        if self.budgetCategory.limit != 0.0{
            return self.budgetCategory.getAmountSpent() / self.budgetCategory.limit
        }
        else{
            return 0.0
        }
    }
    
    var remainingText : some View{
        HStack{
            
            Text( CommonUtils.makeMoneyString(number: self.budgetCategory.getAmountSpent())).font(.system(size: 15)).bold().foregroundColor(Color(.gray)).lineLimit(1)
            Text ("/" ).font(.system(size: 15)).bold().foregroundColor(Color(.gray))
            Text(CommonUtils.makeMoneyString(number: self.budgetCategory.limit)).font(.system(size: 15)).bold().foregroundColor(Color(.gray)).lineLimit(1)
            
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                Text(self.budgetCategory.spendingCategory!.icon!).font(.system(size: 35)).padding(.trailing, 3)
                VStack(alignment: .leading, spacing: 4){
                    HStack{
                        
                        Text(self.budgetCategory.spendingCategory!.name!).font(.system(size: 20)).bold().foregroundColor(Color(.black)).lineLimit(1)
                        Spacer()
                    }
                    
                    remainingText.padding(.trailing, 20)
                }
                
                Spacer()
                
            }.padding(.top).padding(.bottom)
            
            
            
            
            //ProgressBarView(percentage: CGFloat(self.getPercentage()), color: colorMap[Int(budgetCategory.budgetSection!.colorCode)], width: 80, backgroundColor: Color(.white)).padding(.bottom).padding(.horizontal, 20).padding(.top)
            
            
            //Divider()
            
        }
        
    }
}


