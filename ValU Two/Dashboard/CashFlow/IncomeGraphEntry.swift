//
//  IncomeGraphEntry.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeGraphEntry: View {
    
    var fixedWidth = CGFloat(18.0)
    var incomeHeight = CGFloat(100.0)
    var expenseHeight = CGFloat(70.0)
    var maxHeight = CGFloat(175)
    var maxValue : CGFloat
    var entryData : TransactionDateCache
    var viewModel : CashFlowViewModel
    
    init(viewModel: CashFlowViewModel, entryData: TransactionDateCache, maxValue: CGFloat, maxHeight: CGFloat){
        self.entryData = entryData
        self.viewModel = viewModel
        
        self.maxValue = maxValue
        self.maxHeight = maxHeight
        
    }
    
    func getActualIncomeHeight() -> CGFloat{
        
        let ratio = CGFloat(self.entryData.income * -1) / maxValue
        
        return ratio * maxHeight
        
    }
    
    func getActualExpensesHeight() -> CGFloat{
        
        let ratio = CGFloat(self.entryData.expenses) / maxValue
        
        return ratio * maxHeight
        
    }
    
    func getLabel() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        
        return dateFormatter.string(from: self.entryData.startDate!)
        
    }
    
    
    var body: some View {
        
        VStack{
            
            Button(action: {
                // What to perform
                self.viewModel.changeSelectedTimeFrame(timeFrame: self.entryData)
            }) {
                // How the button looks like
                VStack{
                    Spacer()
                    HStack(alignment: .bottom, spacing: 0){
                        Capsule().frame(width: fixedWidth, height: getActualIncomeHeight()).foregroundColor(Color(.systemGreen))
                        Capsule().frame(width: fixedWidth, height: getActualExpensesHeight()).foregroundColor(Color(.systemRed))
                    }
                    Text(getLabel()).foregroundColor(Color(.lightGray))
                }
                
            }
            
            
        }.flipsForRightToLeftLayoutDirection(true)
        .environment(\.layoutDirection, .rightToLeft)
        
    }
}


