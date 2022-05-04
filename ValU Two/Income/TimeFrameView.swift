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
        TimeFrameRow(title: "Semi-Monthly", description: "Starts on the 1st and 15th of each month", timeFrame: TimeFrame.semiMonthly, viewModel: self.viewModel)

    }
    
    var week : some View{
        
        TimeFrameRow(title: "Weekly", description: "Starts on Sunday every week", timeFrame: TimeFrame.weekly, viewModel: self.viewModel)
         
        
    }
    
    var body: some View {
            
            VStack{
                
                
                HStack{
                    StepTitleText(header: "Step 1 of 4", title: "Choose a Budget Period", description: "Budgets will begin and end based on the period you select.").padding(.bottom, 20)
                    Spacer()
                    
                }.padding(.horizontal, 25)
                

                
                Button(action: {
                    self.viewModel.toggleTimeFrame(timeFrame: TimeFrame.monthly)
                }) {
                    // How the button looks like
                    month.padding(.horizontal, 20)
                }.buttonStyle(PlainButtonStyle()).padding(.bottom, 5)
                
                Button(action: {
                    self.viewModel.toggleTimeFrame(timeFrame: TimeFrame.semiMonthly)
                }) {
                    // How the button looks like
                    semiMonth.padding(.horizontal, 20)
                }.buttonStyle(PlainButtonStyle()).padding(.bottom, 5)
                
                Button(action: {
                    self.viewModel.toggleTimeFrame(timeFrame: TimeFrame.weekly)
                }) {
                    // How the button looks like
                    week.padding(.horizontal, 20)
                }.buttonStyle(PlainButtonStyle()).padding(.bottom, 5)
                
                
                Spacer()
                
                if self.viewModel.canSubmit(){
                    Button(action: {
                                  //Button Action
                        self.viewModel.submitResult()
                                  }){
                                      ActionButtonLarge(text: "Done").padding().padding(.horizontal)
                    
                              }
                }
                else{
                    
                    ActionButtonLarge(text: "Done", enabled: false).padding().padding(.horizontal)
                    
                }
                
                
                
                
                

                
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("")
            
            
            
        
    }
}

struct TimeFrameRow: View {
    
    var title : String
    var description : String
    var timeFrame : TimeFrame
    @ObservedObject var viewModel : TimeFrameViewModel
    
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
            Text(self.title).font(.system(size: 24, design: .rounded)).bold().foregroundColor(getTextColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: self.timeFrame))).padding(.bottom, 3)
            Text(self.description).font(.system(size: 14)).foregroundColor(getTextColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: self.timeFrame)))
        }.padding()
        Spacer()
            if self.viewModel.isTimeFrameSelected(timeFrame: self.timeFrame){
                Image(systemName: "checkmark.circle.fill").font(.system(size: 26)).foregroundColor(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: self.timeFrame))).padding(.trailing)
            }
            
        }.padding(5).frame(height: 100).background(self.getBackgroundColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: self.timeFrame))).cornerRadius(23)
        
        
    }
    
    
}

