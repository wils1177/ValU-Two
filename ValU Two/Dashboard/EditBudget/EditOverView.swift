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
    
    @ObservedObject var budget: Budget
    
    init(viewModel: BudgetEditor){
        self.viewModel = viewModel
        self.budget = viewModel.budget
    }
    
    func getToSpend() -> String{
        return CommonUtils.makeMoneyString(number: Int(viewModel.budget.getAmountAvailable()))
    }
    
    var body: some View {
        
                
        ScrollView{
            VStack{
                
                Text("Edit any aspect that contributes towards your overall budget.").font(.system(size: 18, design: .rounded)).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.gray)).padding(.bottom, 15).padding(.horizontal, 15)
                
                GenericOnboardingStepRow(title: "Budget Period", description: self.viewModel.getTimeFrameDescription(), iconName: "calendar", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.systemBackground), subTectColor: colorScheme == .dark ? Color.white : Color.black, textColor: globalAppTheme.themeColorPrimary, completionHandler: self.viewModel.editTimeFrame).padding(.bottom, 5).padding(.horizontal, 20)
                
                
                GenericOnboardingStepRow(title: "Income", description: CommonUtils.makeMoneyString(number: Int(self.viewModel.budget.amount)), iconName: "arrow.down", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.systemBackground), subTectColor: colorScheme == .dark ? Color.white : Color.black, textColor: globalAppTheme.themeColorPrimary,completionHandler: self.viewModel.editIncome).padding(.bottom, 5).padding(.horizontal, 20)
                
                
                GenericOnboardingStepRow(title: "Savings Goal", description: CommonUtils.makeMoneyString(number: Int(self.viewModel.budget.amount * self.viewModel.budget.savingsPercent)), iconName: "dollarsign.circle", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.systemBackground), subTectColor: colorScheme == .dark ? Color.white : Color.black, textColor: globalAppTheme.themeColorPrimary, completionHandler: self.viewModel.editSavings).padding(.bottom, 5).padding(.horizontal, 20)
                
                GenericOnboardingStepRow(title: "Categories", description: getToSpend(), iconName: "creditcard", iconColor: AppTheme().themeColorPrimary, backgroundColor: Color(.systemBackground), subTectColor: colorScheme == .dark ? Color.white : Color.black, textColor: globalAppTheme.themeColorPrimary, completionHandler: self.viewModel.editBudget).padding(.bottom, 5).padding(.horizontal, 20)


                
                
                
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


