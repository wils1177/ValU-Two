//
//  FutureBudgetActionBar.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct FutureBudgetActionBar: View {
    
    var timeFrame: BudgetTimeFrame
    var viewModel: BudgetsViewModel
    
    @State var isShowingDeleteAlert = false
    
    var body: some View {
        HStack{
            if timeFrame.budget == nil{
                Button(action: {
                    //action
                    self.viewModel.userSelectedToCreateNewBudget(timeFrame: self.timeFrame)
                }){
                    Image(systemName: "plus.circle.fill").imageScale(.large)

                    
                }.buttonStyle(BorderlessButtonStyle())
            }
            else{
                HStack{
                    Button(action: {
                        //action
                        self.isShowingDeleteAlert.toggle()
                    }){
                        Image(systemName: "trash.circle.fill").imageScale(.large).foregroundColor(Color(.red))

                        
                    }.buttonStyle(BorderlessButtonStyle())
                    Button(action: {
                        //action
                        self.viewModel.coordinator?.editClicked(budgetToEdit: self.timeFrame.budget!)
                    }){
                        Image(systemName: "pencil.circle.fill").imageScale(.large)

                        
                    }.buttonStyle(BorderlessButtonStyle())
                }
                
            }
        }.alert(isPresented:self.$isShowingDeleteAlert) {
            Alert(title: Text("Are you sure you want to delete this budget?"), message: Text("All associated data will be deleted"), primaryButton: .destructive(Text("Delete")) {
                //Delete Action
                self.viewModel.deleteBudget(id: self.timeFrame.budget!.id!)
            }, secondaryButton: .cancel())
        }

    }
}


