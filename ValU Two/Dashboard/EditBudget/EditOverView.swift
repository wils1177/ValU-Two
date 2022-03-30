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
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        
                
        ScrollView{
            VStack{
                
                Text("Edit any aspect that contributes towards your overall budget.").font(.system(size: 18, design: .rounded)).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.gray)).padding(.bottom, 15).padding(.horizontal, 15)
                
                GenericOnboardingStepRow(title: "Edit Budget Period", description: self.viewModel.getTimeFrameDescription(), iconName: "calendar", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.systemBackground), subTectColor: colorScheme == .dark ? Color.white : Color.black, completionHandler: self.viewModel.editTimeFrame).padding(.bottom, 5).padding(.horizontal, 20)
                
                
                GenericOnboardingStepRow(title: "Edit Income", description: CommonUtils.makeMoneyString(number: Int(self.viewModel.budget.amount)), iconName: "arrow.down", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.systemBackground), subTectColor: colorScheme == .dark ? Color.white : Color.black,completionHandler: self.viewModel.editIncome).padding(.bottom, 5).padding(.horizontal, 20)
                
                
                GenericOnboardingStepRow(title: "Edit Savings Goal", description: CommonUtils.makeMoneyString(number: Int(self.viewModel.budget.amount * self.viewModel.budget.savingsPercent)), iconName: "dollarsign.circle", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.systemBackground), subTectColor: colorScheme == .dark ? Color.white : Color.black, completionHandler: self.viewModel.editSavings).padding(.bottom, 5).padding(.horizontal, 20)
                
                GenericOnboardingStepRow(title: "Edit Budgets", description: "Change indivudal budgets", iconName: "creditcard", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.systemBackground), subTectColor: colorScheme == .dark ? Color.white : Color.black, completionHandler: self.viewModel.editBudget).padding(.bottom, 5).padding(.horizontal, 20)


                
                
                
                Spacer()
            }.padding(.top)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle("Edit Budget", displayMode: .large).navigationBarItems(trailing:
                
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


