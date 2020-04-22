//
//  IncomeSectionView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeSectionView: View {
    var budget: Budget
    var viewModel : IncomeSectionViewModel
    
    var income : String
    var expeceted : String
    var coordinator : BudgetsTabCoordinator?
    
    init(budget: Budget, coordinator: BudgetsTabCoordinator?){
        self.budget = budget
        self.viewModel = IncomeSectionViewModel(budget: budget)
        self.income = "$" + String(Int(viewModel.totalIncome))
        self.expeceted = " / $" + String(Int(viewModel.expectedIncome))
        self.coordinator = coordinator
    }
    
    
    var body: some View {

        VStack{
            HStack{
                Text("Income").font(.system(size: 20)).bold()
                Spacer()
                Text(income).font(.headline).fontWeight(.bold)
            }
            
            
            Divider().padding(.bottom, 15)
            
            Button(action: {
                //action
                self.coordinator?.showIncome()
            }) {
                //BudgetBarView(iconText: "💵", categoryName: "Income", amountSpent: self.income, limitText: self.expeceted, percentage: self.viewModel.percentage)//.padding(.vertical, 5)
                TempBudgetBar(iconText: "💵", categoryName: "Income", amountSpent: self.income, limitText: self.expeceted, percentage: self.viewModel.percentage)
            }.buttonStyle(PlainButtonStyle())
            
        }
        
    }
}


