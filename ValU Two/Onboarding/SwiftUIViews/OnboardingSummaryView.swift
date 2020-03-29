//
//  OnboardingSummaryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct OnboardingSummaryView: View {
    
    @ObservedObject var viewModel : OnboardingSummaryPresentor
    var coordinator : OnboardingFlowCoordinator?
    
    init(viewModel : OnboardingSummaryPresentor){
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Get started with your first budget!").padding()
                Spacer()
            }
            
            
            ForEach(self.viewModel.viewData!.steps, id: \.self) { step in
                OnboardingStepRow(viewData: step)
            }
            
            Spacer()
            
            
        }.navigationBarTitle(Text("Setup Your Budget"),  displayMode: .large)
    }
}


