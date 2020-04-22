//
//  NewBudgetView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct NewBudgetView: View {
    
    @ObservedObject var viewModel : CreateBudgetViewModel

    
    var body: some View {
        ScrollView{
            VStack{
                
                HStack{
                    Text("Create a new budget:").padding()
                    Spacer()
                }
                
                
                ForEach(self.viewModel.viewData!.steps, id: \.self) { step in
                    OnboardingStepRow(viewData: step)
                }
                
                Spacer()
                

                
                
                
            }
        }.navigationBarTitle(Text("New Budget"),  displayMode: .large).navigationBarItems(trailing:
                
                Button(action: {
                    self.viewModel.cancel()
                }){
                ZStack{
                    
                    Text("Cancel")
                }
                }
                
                
                
            )
    }
}

