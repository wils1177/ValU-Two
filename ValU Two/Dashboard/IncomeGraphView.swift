//
//  IncomeGraphView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeGraphView: View {
    
    var viewModel : CashFlowViewModel
    var maxHeight = CGFloat(150)
    var viewData : [TransactionDateCache]
    
    
    var body: some View {
        
        ZStack{
            GraphBackground()
            VStack{
                ScrollView(.horizontal){
                    HStack(alignment: .bottom){
                        ZStack{
                            
                            HStack{
                                ForEach(self.viewData, id: \.self) { week in
                                    IncomeGraphEntry(viewModel: self.viewModel, entryData: week, maxValue: CGFloat(self.viewModel.largestWeekAmount!), maxHeight: self.maxHeight).padding(.horizontal).offset(y: -6)
                                }
                            }
                            
                        }
                    }
                }.flipsForRightToLeftLayoutDirection(true)
                .environment(\.layoutDirection, .rightToLeft)
            }
        }

        
        
        
    }
}


