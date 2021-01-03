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
                                  HStack{
                                      Spacer()
                                      ZStack{
                                          Text("Done").font(.subheadline).foregroundColor(Color(.systemBackground)).bold().padding()
                                      }
                                      Spacer()
                                  }.background(AppTheme().themeColorPrimary).cornerRadius(10).shadow(radius: 10).padding().padding(.horizontal).padding(.bottom)
                    
                              }
                }
                else{
                    
                    HStack{
                        Spacer()
                        ZStack{
                            Text("Done").font(.subheadline).foregroundColor(Color(.systemBackground)).bold().padding()
                        }
                        Spacer()
                    }.background(Color(.lightGray)).cornerRadius(15).shadow(radius: 0).padding().padding(.horizontal).padding(.bottom)
                    
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
            return Color(.gray)
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
            
        }.background(Color(red: 0.96, green: 0.96, blue: 0.96)).cornerRadius(15).overlay(
        RoundedRectangle(cornerRadius: 15)
            .stroke(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: self.timeFrame)), lineWidth: 3)
        )
        
    }
    
    
}

