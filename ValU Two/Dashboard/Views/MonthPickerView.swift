//
//  MonthPickerView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct MonthPickerView: View {
            
    @ObservedObject var viewModel : SetMonthViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text("Select a month for your budget. You can only select months that you've not already createrd a budget for")
                Spacer()
            }.padding(.horizontal).padding(.top)
            
            if self.viewModel.error{
                
                HStack(){
                    Spacer()
                    Text("You can only select a month you have no existing budget for!").foregroundColor(Color.red).bold()
                    Spacer()
                }.padding(.horizontal).padding(.top).padding(.top)
                
            }
            
            
            Spacer()
            Picker(selection: self.$viewModel.currentSelectedMonth, label: Text("Month")) {
                
                ForEach(0 ..< self.viewModel.monthOptions.count) { i in
                    Text("\(self.viewModel.monthOptions[i])").tag(i)
                }
                
                
            }.pickerStyle(WheelPickerStyle()).labelsHidden()
            
            Spacer()
            Button(action: {
                //Button Action
                self.viewModel.saveCurrentMonth()
                }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Save").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    Spacer()
                }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
                
                
            }
        }.navigationBarTitle("Choose a Month")
    }
}
