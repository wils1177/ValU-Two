//
//  BudgetTypeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetTypeView: View {
    
    
    var timePickerOptions = ["Monthly" ,"SemiMonthly", "Weekly"]
    var recurringOptions = ["Repeating" ,"One-Time"]
    
    @ObservedObject var viewModel : BudgetTypePresentor
    

    
    var timePicker: some View{
        Picker("Time Frame", selection: self.$viewModel.currentTimeSelected) {
                Text(self.timePickerOptions[0]).tag(0)
                Text(self.timePickerOptions[1]).tag(1)
                Text(self.timePickerOptions[2]).tag(2)
                Text(self.timePickerOptions[3]).tag(3)
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    var recurringPicker: some View{
        Picker("Time Frame", selection: self.$viewModel.currentRecurringSelected) {
                Text(self.recurringOptions[0]).tag(0)
                Text(self.recurringOptions[1]).tag(1)
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    var timePickerDisabled : Bool {
        self.viewModel.currentTimeSelected == 0 || self.viewModel.currentTimeSelected == 1 || self.viewModel.currentTimeSelected == 2
    }
    
    var buttonColor: Color {
           return timePickerDisabled ? .accentColor : .gray
       }
    
    var body: some View {

        Form{
            Section(header: Text("Set A Budget Name")) {
                TextField("Name", text: $viewModel.name)
                
            }
            Section(header: Text("Set A Budget Length")) {
                timePicker
                
            }
            if !self.timePickerDisabled{
                Section(header: Text("Set A Time Frame")) {
                    DatePicker(selection: self.$viewModel.startDate, in: ...Date(), displayedComponents: .date) {
                        Text("Start Date").foregroundColor(buttonColor)
                    }
                    
                    DatePicker(selection: self.$viewModel.endDate, in: ...Date(), displayedComponents: .date) {
                        Text("End Date").foregroundColor(buttonColor)
                    }
                    
                }.disabled(timePickerDisabled)
            }
            
            Section(header: Text("Is this budget a one-time budget?")) {
                recurringPicker
                
            }
            
        }.navigationBarTitle("Budget Type").navigationBarItems(
                                                           
                                                           
        trailing: Button(action: {
            //action
            self.viewModel.confirm()
        }){
        Text("Confirm").padding(.leading)
        })
        
    }
}


