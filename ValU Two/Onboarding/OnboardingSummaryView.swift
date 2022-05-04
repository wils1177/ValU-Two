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
    
    @ObservedObject var budget : Budget
    
    init(viewModel : OnboardingSummaryPresentor){
        self.viewModel = viewModel
        self.budget = viewModel.budget
        
        // To remove only extra separators below the list:
        //UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        //UITableView.appearance().separatorStyle = .none
        
     
        
        
    }
    
    func getBankConnectionDescription() -> String{
        return String(self.itemManagerService.getItems().count) + " account connected"
    }
    
    var body: some View {
        
        ScrollView{
            
            VStack{
                
                VStack{
                        //Text("👋").font(.system(size: 42)).padding(.top)
                        VStack{
                            Text("Follow these steps to get started creating your very first budget!").font(.system(size: 17, weight: .semibold, design: .rounded)).padding(.top, 15).foregroundColor(Color(.gray)).multilineTextAlignment(.leading)
                        }
                }.padding(.vertical, 30).padding(.horizontal)

    
                
            
                GenericOnboardingStepRow(title: self.viewModel.viewData!.steps[0].title, description: self.viewModel.viewData!.steps[0].description, iconName: self.viewModel.viewData!.steps[0].iconName, iconColor: self.viewModel.viewData!.steps[0].iconColor, backgroundColor: self.viewModel.viewData!.steps[0].backgroundColor, subTectColor: self.viewModel.viewData!.steps[0].subTectColor, textColor: self.viewModel.viewData!.steps[0].textColor, completionHandler: self.viewModel.viewData!.steps[0].completionHandler).padding(.horizontal, 20).padding(.bottom, 10)

            
                GenericOnboardingStepRow(title: self.viewModel.viewData!.steps[1].title, description: self.viewModel.viewData!.steps[1].description, iconName: self.viewModel.viewData!.steps[1].iconName, iconColor: self.viewModel.viewData!.steps[1].iconColor, backgroundColor: self.viewModel.viewData!.steps[1].backgroundColor, subTectColor: self.viewModel.viewData!.steps[1].subTectColor, textColor: self.viewModel.viewData!.steps[1].textColor, completionHandler: self.viewModel.viewData!.steps[1].completionHandler).padding(.horizontal, 20).padding(.bottom, 10)
            
                GenericOnboardingStepRow(title: self.viewModel.viewData!.steps[2].title, description: self.viewModel.viewData!.steps[2].description, iconName: self.viewModel.viewData!.steps[2].iconName, iconColor: self.viewModel.viewData!.steps[2].iconColor, backgroundColor: self.viewModel.viewData!.steps[2].backgroundColor, subTectColor: self.viewModel.viewData!.steps[2].subTectColor, textColor: self.viewModel.viewData!.steps[2].textColor, completionHandler: self.viewModel.viewData!.steps[2].completionHandler).padding(.horizontal, 20).padding(.bottom, 10)
            
                GenericOnboardingStepRow(title: self.viewModel.viewData!.steps[3].title, description: self.viewModel.viewData!.steps[3].description, iconName: self.viewModel.viewData!.steps[3].iconName, iconColor: self.viewModel.viewData!.steps[3].iconColor, backgroundColor: self.viewModel.viewData!.steps[3].backgroundColor, subTectColor: self.viewModel.viewData!.steps[3].subTectColor, textColor: self.viewModel.viewData!.steps[3].textColor, completionHandler: self.viewModel.viewData!.steps[3].completionHandler).padding(.horizontal, 20).padding(.bottom, 10)
            
          
                Spacer()
            
            
                
            }
                  
            
            }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle(Text("New Budget"),  displayMode: .large).navigationBarItems(
                                                                       
                                                                       
                    trailing: Button(action: {
                        self.viewModel.dismiss()
                    }){
                    ZStack{
                        
                        NavigationBarTextButton(text: "Cancel")
                    }
            })
        
    }
}


