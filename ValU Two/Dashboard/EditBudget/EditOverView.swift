//
//  EditOverView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditOverView: View {
    
    var viewModel : BudgetEditor
    
    
    
    var body: some View {
        
                
        ScrollView{
            VStack{
                
                GenericOnboardingStepRow(title: "Edit Time Frame", description: self.viewModel.getTimeFrameDescription(), iconName: "calendar", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.black), subTectColor: Color(.gray), completionHandler: self.viewModel.editTimeFrame).padding(.bottom, 5).padding(.horizontal)
                
                
                GenericOnboardingStepRow(title: "Edit Income", description: "$" + String(Int(self.viewModel.budget.amount)), iconName: "arrow.down.circle.fill", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.black), subTectColor: Color(.gray), completionHandler: self.viewModel.editIncome).padding(.bottom, 5).padding(.horizontal)
                
                
                GenericOnboardingStepRow(title: "Edit Savings Goal", description: "$" + String(Int(self.viewModel.budget.amount * self.viewModel.budget.savingsPercent)), iconName: "dollarsign.circle.fill", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.black), subTectColor: Color(.gray), completionHandler: self.viewModel.editSavings).padding(.bottom, 5).padding(.horizontal)
                
                GenericOnboardingStepRow(title: "Edit Budgets", description: "temp", iconName: "creditcard.fill", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.black), subTectColor: Color(.gray), completionHandler: self.viewModel.editBudget).padding(.bottom, 5).padding(.horizontal)


                
                
                
                Spacer()
            }.padding(.top)
        }
        
        .navigationBarTitle("Edit", displayMode: .large).navigationBarItems(trailing:
                
                HStack{

                    Button(action: {
                        self.viewModel.dismiss()
                    }){
                        
                        NavigationBarTextButton(text: "Done")
                        
                    }
                }
            
            
            
            
            
        )
                
                
                
                

                
                
            
        
        
    }
}


