//
//  CashFlowFullScreenView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/23/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CashFlowFullScreenView: View {
    
    var viewModel : CashFlowViewModel
    
    var body: some View {
        VStack{
            IncomeCardView(viewModel: self.viewModel).padding()
            Spacer()
        }.navigationBarTitle("Cash Flow")
    }
}


