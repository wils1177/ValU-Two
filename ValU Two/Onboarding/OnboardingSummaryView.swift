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
    @EnvironmentObject var itemManagerService : ItemManagerService
    
    
    init(viewModel : OnboardingSummaryPresentor){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        //UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        //UITableView.appearance().separatorStyle = .none
        
        
        UITableViewCell.appearance().backgroundColor = .systemGroupedBackground
        UITableView.appearance().backgroundColor = .systemGroupedBackground
        
        
    }
    
    func getBankConnectionDescription() -> String{
        return String(self.itemManagerService.getItems().count) + " account connected"
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
            
            GenericOnboardingStepRow(title: self.viewModel.viewData!.steps[0].title, description: self.viewModel.viewData!.steps[0].description, iconName: self.viewModel.viewData!.steps[0].iconName, iconColor: self.viewModel.viewData!.steps[0].iconColor, backgroundColor: self.viewModel.viewData!.steps[0].backgroundColor, subTectColor: self.viewModel.viewData!.steps[0].subTectColor, completionHandler: self.viewModel.viewData!.steps[0].completionHandler)

            
            GenericOnboardingStepRow(title: self.viewModel.viewData!.steps[1].title, description: self.viewModel.viewData!.steps[1].description, iconName: self.viewModel.viewData!.steps[1].iconName, iconColor: self.viewModel.viewData!.steps[1].iconColor, backgroundColor: self.viewModel.viewData!.steps[1].backgroundColor, subTectColor: self.viewModel.viewData!.steps[1].subTectColor, completionHandler: self.viewModel.viewData!.steps[1].completionHandler)
            
            GenericOnboardingStepRow(title: self.viewModel.viewData!.steps[2].title, description: self.viewModel.viewData!.steps[2].description, iconName: self.viewModel.viewData!.steps[2].iconName, iconColor: self.viewModel.viewData!.steps[2].iconColor, backgroundColor: self.viewModel.viewData!.steps[2].backgroundColor, subTectColor: self.viewModel.viewData!.steps[2].subTectColor, completionHandler: self.viewModel.viewData!.steps[2].completionHandler)
            
            GenericOnboardingStepRow(title: self.viewModel.viewData!.steps[3].title, description: self.viewModel.viewData!.steps[3].description, iconName: self.viewModel.viewData!.steps[3].iconName, iconColor: self.viewModel.viewData!.steps[3].iconColor, backgroundColor: self.viewModel.viewData!.steps[3].backgroundColor, subTectColor: self.viewModel.viewData!.steps[3].subTectColor, completionHandler: self.viewModel.viewData!.steps[3].completionHandler)
            
          
                Spacer()
                
                
            
            }.navigationBarTitle(Text("New Budget"),  displayMode: .large).navigationBarItems(
                                                                       
                                                                       
                    trailing: Button(action: {
                        self.viewModel.dismiss()
                    }){
                    ZStack{
                        
                        Text("Cancel")
                    }
            })
        
    }
}


