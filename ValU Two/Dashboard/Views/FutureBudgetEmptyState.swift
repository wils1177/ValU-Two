//
//  FutureBudgetEmptyState.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct FutureBudgetEmptyState: View {
    
    var viewModel : BudgetsTabViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text("Any budget future you budgets you plan will show up here.").foregroundColor(Color(.lightGray))
                Spacer()
            }.padding(.horizontal).padding(.bottom)

                
            VStack{
                HStack{
                    Spacer()
                    
                    AddFutureBudgetButton(viewModel: self.viewModel, isSmall: false)


                    Spacer()
                }.padding()
                }.background(Color(.lightGray)).cornerRadius(10).padding()
        }
    }
}


