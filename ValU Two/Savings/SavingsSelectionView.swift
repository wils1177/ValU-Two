//
//  SavingsSelectionView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/31/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

enum SavingsGoals {
    case Aggressive
    case Moderate
    case Custom
}

struct SavingsSelectionView: View {
    
    @ObservedObject var viewModel : SetSavingsPresentor
    
    var body: some View {
        VStack(spacing: 10){
            
            HStack{
                StepTitleText(header: "Step 3 of 4", title: "Savings Goal", description: "Choose a savings goal for your budget.").padding(.bottom, 20)
                Spacer()
                
            }.padding(.horizontal, 25)
            
            Button(action: {
                self.viewModel.selectedPresetButton(goal: SavingsGoals.Aggressive)
            }) {
                SetSavingsRow(title: "Aggressive", description: "Save at a high rate.", displayPercent: "25%", savingsGoal: SavingsGoals.Aggressive, savingsAmount: self.viewModel.getSavingsAmountForGoal(goal: SavingsGoals.Aggressive), spendingAmount: self.viewModel.getSpendingAmountForGoal(goal: SavingsGoals.Aggressive), viewModel: self.viewModel).padding(.horizontal, 20).padding(.bottom, 5)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.viewModel.selectedPresetButton(goal: SavingsGoals.Moderate)
            }) {
                SetSavingsRow(title: "Moderate", description: "Save at the reccomended rate.", displayPercent: "15%", savingsGoal: SavingsGoals.Moderate, savingsAmount: self.viewModel.getSavingsAmountForGoal(goal: SavingsGoals.Moderate), spendingAmount: self.viewModel.getSpendingAmountForGoal(goal: SavingsGoals.Moderate), viewModel: self.viewModel).padding(.horizontal, 20).padding(.bottom, 5)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.viewModel.coordinator!.userTappedCustomSavings(presentor: self.viewModel)
            }) {
                SetSavingsRow(title: "Custom", description: "Choose a custom savings rate.", displayPercent: self.viewModel.getCustomDisplayPercentage(), savingsGoal: SavingsGoals.Custom, savingsAmount: self.viewModel.getSavingsAmountForGoal(goal: SavingsGoals.Custom), spendingAmount: self.viewModel.getSpendingAmountForGoal(goal: SavingsGoals.Custom), viewModel: self.viewModel).padding(.horizontal, 20).padding(.bottom, 5)
            }.buttonStyle(PlainButtonStyle())
            
         
            
            Spacer()
            
            Button(action: {
                          //Button Action
                self.viewModel.coordinator?.savingsSubmitted(budget: self.viewModel.budget, sender: self.viewModel)
                          }){
                ActionButtonLarge(text: "Done")
            
                }
            
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle(Text(""))
    }
}


struct SetSavingsRow: View {
    
    var title : String
    var description : String
    var displayPercent: String
    
    var savingsGoal : SavingsGoals
    
    var savingsAmount : String
    var spendingAmount : String
    
    @ObservedObject var viewModel : SetSavingsPresentor
    
    @Environment(\.colorScheme) var colorScheme
    
    func getSelectionColor(selected: Bool) -> Color{
        if selected{
            return AppTheme().themeColorPrimary
        }
        else{
            return Color(.clear)
        }
    }
    
    func getBackgroundColor(selected: Bool) -> Color{
        if selected{
            return AppTheme().themeColorPrimary.opacity(0.15)
        }
        else{
            return Color(.tertiarySystemBackground)
        }
    }
    
    func getTextColor(selected: Bool) -> Color{
        if selected{
            return AppTheme().themeColorPrimary
        }
        else{
            return colorScheme == .dark ? Color.white : Color.black
        }
    }
    
    
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading, spacing: 2){
                Text(self.title).font(.system(size: 24, design: .rounded)).foregroundColor(getTextColor(selected: self.viewModel.isGoalSelected(goal: self.savingsGoal))).bold()
            
                //Text(self.description).font(.system(size: 15, design: .rounded)).foregroundColor(getTextColor(selected: self.viewModel.isGoalSelected(goal: self.savingsGoal))).padding(.vertical, 3)
            HStack{
                
                VStack(alignment: .leading){
                    Text("Save: \(Text(savingsAmount))").foregroundColor(Color(.systemGreen)).font(.system(size: 15, weight: .semibold))
                    Text("Spend: \(Text(spendingAmount))").foregroundColor(Color(.systemRed)).font(.system(size: 15, weight: .semibold))
                }
                
                Spacer()
                 
            }.padding(.top, 5)
        }.padding()
        Spacer()
            
            Text(self.displayPercent).font(.system(size: 26, design: .rounded)).bold().foregroundColor(getSelectionColor(selected: self.viewModel.isGoalSelected(goal: self.savingsGoal))).padding(.trailing)

        }.padding(.vertical, 10).background(self.getBackgroundColor(selected: self.viewModel.isGoalSelected(goal: self.savingsGoal))).cornerRadius(23)
        
    }
    
    
}
