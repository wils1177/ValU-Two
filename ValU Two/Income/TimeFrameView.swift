//
//  TimeFrameView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TimeFrameView: View {
    
    @State var monthSelected = true
    @ObservedObject var viewModel : TimeFrameViewModel
    

    
    var month : some View{
        
        TimeFrameRow(title: "Monthly", description: "Starts on the first of each month", timeFrame: TimeFrame.monthly, viewModel: self.viewModel)
    }
        
    
    
    var semiMonth : some View{
        TimeFrameRow(title: "Semi-Monthly", description: "1st and 15th of each month", timeFrame: TimeFrame.semiMonthly, viewModel: self.viewModel)

    }
    
    var week : some View{
        
        TimeFrameRow(title: "Weekly", description: "Starts every Sunday", timeFrame: TimeFrame.weekly, viewModel: self.viewModel)
         
        
    }
    
    var body: some View {
            
            VStack{
                
                
                HStack{
                    StepTitleText(header: "Step 1 of 4", title: "Time Frame", description: "Enter what time frame to use for your budget.").padding(.bottom, 20)
                    Spacer()
                    
                }.padding(.leading)
                

                
                Button(action: {
                    self.viewModel.toggleTimeFrame(timeFrame: TimeFrame.monthly)
                }) {
                    // How the button looks like
                    month.padding(.horizontal)
                }.buttonStyle(PlainButtonStyle()).padding(.bottom, 5)
                
                Button(action: {
                    self.viewModel.toggleTimeFrame(timeFrame: TimeFrame.semiMonthly)
                }) {
                    // How the button looks like
                    semiMonth.padding(.horizontal)
                }.buttonStyle(PlainButtonStyle()).padding(.bottom, 5)
                
                Button(action: {
                    self.viewModel.toggleTimeFrame(timeFrame: TimeFrame.weekly)
                }) {
                    // How the button looks like
                    week.padding(.horizontal)
                }.buttonStyle(PlainButtonStyle()).padding(.bottom, 5)
                
                
                Spacer()
                
                if self.viewModel.canSubmit(){
                    Button(action: {
                                  //Button Action
                        self.viewModel.submitResult()
                                  }){
                        ActionButtonLarge(text: "Done")
                    
                              }
                }
                else{
                    
                    ActionButtonLarge(text: "Done", enabled: false)
                    
                }
                
                
                
                
                

                
            }.navigationBarTitle("")
            
            
            
        
    }
}

struct TimeFrameRow: View {
    
    var title : String
    var description : String
    var timeFrame : TimeFrame
    @ObservedObject var viewModel : TimeFrameViewModel
    
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
            Text(self.description).font(.system(size: 15)).foregroundColor(Color(.gray))
        }.padding()
        Spacer()
            if self.viewModel.isTimeFrameSelected(timeFrame: self.timeFrame){
                Image(systemName: "checkmark.circle.fill").imageScale(.large).foregroundColor(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: self.timeFrame))).padding(.trailing)
            }
            
        }.background(Color(.tertiarySystemGroupedBackground)).cornerRadius(15).overlay(
        RoundedRectangle(cornerRadius: 15)
            .stroke(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: self.timeFrame)), lineWidth: 3)
        )
        
    }
    
    
}

