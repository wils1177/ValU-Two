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
    
    init(viewModel : OnboardingSummaryPresentor){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        
        UITableViewCell.appearance().backgroundColor = .systemGroupedBackground
        UITableView.appearance().backgroundColor = .systemGroupedBackground
        
    }
    
    var body: some View {
        
        List{
                
                HStack{
                    VStack{
                        Text("👋").font(.system(size: 39)).padding(.leading).padding(.top)
                        VStack{
                            Text("Hi there! Follow these steps to get started creating your very first budget!").font(.callout).padding(.top, 15).padding(.leading).multilineTextAlignment(.center)
                        }
                    }

                    Spacer()
                }.padding(.bottom, 20)
                
                
                ForEach(self.viewModel.viewData!.steps, id: \.self) { step in
                    OnboardingStepRow(viewData: step)
                }
                
                Spacer()
                
                
            
            }.navigationBarTitle(Text("Get Started"),  displayMode: .large)
        
    }
}


