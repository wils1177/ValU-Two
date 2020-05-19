//
//  IncomeGraphEntry.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeGraphEntry: View {
    
    var fixedWidth = CGFloat(12.0)
    var incomeHeight = CGFloat(100.0)
    var expenseHeight = CGFloat(70.0)
    var maxHeight : CGFloat
    var entryData : TransactionDateCache
    @ObservedObject var viewModel : CashFlowViewModel
    
    var scale : Int
    
    init(viewModel: CashFlowViewModel, entryData: TransactionDateCache, maxHeight: CGFloat, scale: Int){
        self.entryData = entryData
        self.viewModel = viewModel
        
        self.maxHeight = maxHeight - 18
        
        self.scale = scale
        
    }
    
    func getActualIncomeHeight() -> CGFloat{
        
        let ratio = CGFloat(self.entryData.income * -1) / CGFloat(scale * 4)
        
        return ratio * maxHeight
        
    }
    
    func getActualExpensesHeight() -> CGFloat{
        
        let ratio = CGFloat(self.entryData.expenses) / CGFloat(scale * 4)
        return ratio * maxHeight
        
    }
    
    func getLabel() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        
        return dateFormatter.string(from: self.entryData.startDate!)
        
    }
    
    
    var body: some View {
        
        VStack(spacing: 0){
            Spacer()
            Button(action: {
                // What to perform
                self.viewModel.changeSelectedTimeFrame(timeFrame: self.entryData)
            }) {
                // How the button looks like
                ZStack(alignment: .bottom){
                    VStack(spacing: 0){

                        HStack(alignment: .bottom, spacing: 0){
                            Capsule().frame(width: fixedWidth, height: getActualIncomeHeight()).foregroundColor(Color(.systemGreen))
                            Capsule().frame(width: fixedWidth, height: getActualExpensesHeight()).foregroundColor(Color(.systemRed))
                        }.padding(.top)
                        Text(getLabel()).foregroundColor(Color(.lightGray))
                        
                        
                    }
                    if self.viewModel.isSelected(timeFrame: self.entryData){
                        Capsule().frame(width: fixedWidth * 4.0, height: maxHeight  + 30).foregroundColor(Color(.tertiarySystemFill))
                    }
                    
                }
                
                
            }
            
            
        }.flipsForRightToLeftLayoutDirection(true)
        .environment(\.layoutDirection, .rightToLeft)
        
    }
}


