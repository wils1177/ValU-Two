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
    
    func getSelectionColor(selected: Bool) -> Color{
        if selected{
            return AppTheme().themeColorPrimary
        }
        else{
            return Color(.clear)
        }
    }
    

    

    
    var month : some View{
        
        HStack{
        VStack(alignment: .leading){
            Text("Monthly").font(.system(size: 22)).bold().padding(.bottom ,5)
            Text("Starts first of each month").font(.subheadline).foregroundColor(Color(.gray))
        }.padding()
        Spacer()
            Image(systemName: "checkmark.circle.fill").imageScale(.large).foregroundColor(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: TimeFrame.monthly))).padding(.trailing).padding(.trailing)
        }.background(Color(red: 0.96, green: 0.96, blue: 0.96)).cornerRadius(15).overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: TimeFrame.monthly)), lineWidth: 3)
        )
    }
        
    
    
    var semiMonth : some View{
        
        HStack{
        VStack(alignment: .leading){
            Text("Semi-Monthly").font(.system(size: 22)).bold().padding(.bottom ,5)
            Text("Twice each month").font(.subheadline).foregroundColor(Color(.gray))
        }.padding()
        Spacer()
            Image(systemName: "checkmark.circle.fill").imageScale(.large).foregroundColor(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: TimeFrame.semiMonthly))).padding(.trailing).padding(.trailing)
        }.background(Color(red: 0.96, green: 0.96, blue: 0.96)).cornerRadius(15).overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: TimeFrame.semiMonthly)), lineWidth: 3)
        )
         
        
    }
    
    var week : some View{
        
        HStack{
        VStack(alignment: .leading){
            Text("Weekly").font(.system(size: 22)).bold().padding(.bottom ,5)
            Text("Starts every sunday").font(.subheadline).foregroundColor(Color(.gray))
        }.padding()
        Spacer()
            Image(systemName: "checkmark.circle.fill").imageScale(.large).foregroundColor(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: TimeFrame.weekly))).padding(.trailing).padding(.trailing)
        }.background(Color(red: 0.96, green: 0.96, blue: 0.96)).cornerRadius(15).overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(self.getSelectionColor(selected: self.viewModel.isTimeFrameSelected(timeFrame: TimeFrame.weekly)), lineWidth: 3)
        )
         
        
    }
    
    var body: some View {
            
            VStack{
                
                
                Text("Select the time frame you'd like to use for your budget. You can always change this later on. ").font(.callout).foregroundColor(Color(.gray)).padding()
                
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
                                          Text("Continue").font(.subheadline).foregroundColor(Color(.systemBackground)).bold().padding()
                                      }
                                      Spacer()
                                  }.background(AppTheme().themeColorPrimary).cornerRadius(10).shadow(radius: 10).padding().padding(.horizontal).padding(.bottom)
                    
                              }
                }
                else{
                    
                    HStack{
                        Spacer()
                        ZStack{
                            Text("Continue").font(.subheadline).foregroundColor(Color(.systemBackground)).bold().padding()
                        }
                        Spacer()
                    }.background(Color(.lightGray)).cornerRadius(15).shadow(radius: 0).padding().padding(.horizontal).padding(.bottom)
                    
                }
                
                
                
                
                

                
            }.navigationBarTitle("Frequency")
            
            
            
        
    }
}

