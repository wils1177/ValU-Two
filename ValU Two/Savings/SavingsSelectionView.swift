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
                
            }.padding(.leading)
            
            Button(action: {
                self.viewModel.selectedPresetButton(goal: SavingsGoals.Aggressive)
            }) {
                SetSavingsRow(title: "Aggressive", description: "Save at a high rate.", displayPercent: "25%", savingsGoal: SavingsGoals.Aggressive, savingsAmount: self.viewModel.getSavingsAmountForGoal(goal: SavingsGoals.Aggressive), spendingAmount: self.viewModel.getSpendingAmountForGoal(goal: SavingsGoals.Aggressive), viewModel: self.viewModel).padding(.horizontal).padding(.bottom, 5)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.viewModel.selectedPresetButton(goal: SavingsGoals.Moderate)
            }) {
                SetSavingsRow(title: "Moderate", description: "Save at the reccomended rate.", displayPercent: "15%", savingsGoal: SavingsGoals.Moderate, savingsAmount: self.viewModel.getSavingsAmountForGoal(goal: SavingsGoals.Moderate), spendingAmount: self.viewModel.getSpendingAmountForGoal(goal: SavingsGoals.Moderate), viewModel: self.viewModel).padding(.horizontal).padding(.bottom, 5)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.viewModel.coordinator!.userTappedCustomSavings(presentor: self.viewModel)
            }) {
                SetSavingsRow(title: "Custom", description: "Choose a custom savings rate.", displayPercent: self.viewModel.getCustomDisplayPercentage(), savingsGoal: SavingsGoals.Custom, savingsAmount: self.viewModel.getSavingsAmountForGoal(goal: SavingsGoals.Custom), spendingAmount: self.viewModel.getSpendingAmountForGoal(goal: SavingsGoals.Custom), viewModel: self.viewModel).padding(.horizontal).padding(.bottom, 5)
            }.buttonStyle(PlainButtonStyle())
            
         
            
            Spacer()
            
            Button(action: {
                          //Button Action
                self.viewModel.coordinator?.savingsSubmitted(budget: self.viewModel.budget, sender: self.viewModel)
                          }){
                ActionButtonLarge(text: "Done")
            
                }
            
        }.navigationBarTitle(Text(""))
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
    
    func getSelectionColor(selected: Bool) -> Color{
        if selected{
            return AppTheme().themeColorPrimary
        }
        else{
            return Color(.systemGray4)
        }
    }
    
    
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading, spacing: 2){
            Text(self.title).font(.system(size: 19)).bold()
            
                Text(self.description).font(.system(size: 15)).foregroundColor(Color(.gray)).padding(.bottom, 1)
            HStack{
                Image(systemName: "arrow.up.circle").foregroundColor(Color(.systemGreen)).font(.system(size: 14))
                Text(savingsAmount).foregroundColor(Color(.systemGreen)).font(.system(size: 14)).bold()
                Text(" ").foregroundColor(Color(.gray)).font(.system(size: 14)).bold()
                Image(systemName: "arrow.down.circle").foregroundColor(Color(.systemRed)).font(.system(size: 14))
                Text(spendingAmount).foregroundColor(Color(.systemRed)).font(.system(size: 14)).bold()
                Spacer()
            }
        }.padding()
        Spacer()
            
            Text(self.displayPercent).font(.title).bold().foregroundColor(getSelectionColor(selected: self.viewModel.isGoalSelected(goal: self.savingsGoal))).padding(.trailing)

        }.background(Color(.tertiarySystemGroupedBackground)).cornerRadius(15).overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(getSelectionColor(selected: self.viewModel.isGoalSelected(goal: self.savingsGoal)), lineWidth: 3)
            )
        
    }
    
    
}
