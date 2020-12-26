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
            Text( CommonUtils.makeMoneyString(number: self.budgetCategory.getAmountSpent())).font(.system(size: 15))
            Text (" / " ).font(.system(size: 15))
            Text(CommonUtils.makeMoneyString(number: self.budgetCategory.limit)).font(.system(size: 15))
            
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                Text(self.budgetCategory.spendingCategory!.name!).font(.system(size: 18)).bold()
                Spacer()
                remainingText.padding(.trailing, 20)
            }.padding(.top).padding(.bottom)
            
            
            
            
            //ProgressBarView(percentage: CGFloat(self.getPercentage()), color: colorMap[Int(budgetCategory.budgetSection!.colorCode)], width: 80, backgroundColor: Color(.white)).padding(.bottom).padding(.horizontal, 20).padding(.top)
            
            
            //Divider()
            
        }
        
    }
}


