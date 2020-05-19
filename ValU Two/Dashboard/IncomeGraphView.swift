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
    var maxHeight = CGFloat(260)
    var viewData : [TransactionDateCache]
    
    
    func selectScale() -> Int{
        let largestValue = self.viewModel.findLargestAmount(amounts: self.viewData)

        if largestValue > 8000{
            return 5000
        }
        else if largestValue > 4000{
            return 2000
        }
        else if largestValue > 2000 {
            return 1000
        }
        else if largestValue > 800 {
            return 500
        }
        else if largestValue > 400 {
            return 200
        }
        else if largestValue > 200 {
            return 100
        }
        else{
            return 50
        }
    }
    

    
    
    var body: some View {
        
        VStack(spacing: 0){
            
            
            ZStack(alignment: .bottom){
                
                    GraphBackground(viewModel: self.viewModel, viewData: self.viewData, scale: self.selectScale(), maxHeight: self.maxHeight)
                        
                        ScrollView(.horizontal){
                            HStack(alignment: .bottom){
                                ZStack{
                                    
                                    HStack(alignment: .bottom){
                                        ForEach(self.viewData, id: \.self) { week in
                                            IncomeGraphEntry(viewModel: self.viewModel, entryData: week, maxHeight: self.maxHeight, scale: self.selectScale()).padding(.horizontal)
                                        }
                                    }
                                    
                                }
                            }.frame(height: self.maxHeight + 25)
                        }.flipsForRightToLeftLayoutDirection(true)
                        .environment(\.layoutDirection, .rightToLeft)
                
                            .offset(x: -40, y: 11)
                
                        
                
                
                
                
            }
        }
        
        

        
        
        
    }
}


