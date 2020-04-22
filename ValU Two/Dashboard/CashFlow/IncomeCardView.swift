//
//  IncomeCardView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeCardView: View {
    
    @State var pickerOptions = ["Weekly", "Semi-Monthly", "Monthly"]
    @ObservedObject var viewModel : CashFlowViewModel
    
    
    var title: some View{
        HStack{
            Text("Cash Flow").font(.title).bold()
            Spacer()
        }
    }
    var picker: some View{
        Picker("", selection: self.$viewModel.segement) {
            ForEach(0 ..< pickerOptions.count) { index in
                Text(self.pickerOptions[index]).tag(index)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    var timeFrameTitle: some View{
        HStack{
            Text("January").font(.headline).foregroundColor(Color(.lightGray)).bold()
            Spacer()
        }.padding(.bottom).padding(.top , 5)
    }
    
    func dateToMonth(date: Date){
        
    }
    
    func dateToWeek(date: Date){
        
    }
    
    func dateToBiMonth(date: Date){
        
    }
    
    var body: some View {
        
        VStack{
            if self.viewModel.weekData.count > 0{
                
                VStack{
                    
                    self.title
                    self.picker
                    self.timeFrameTitle
                    
                    
                    if self.viewModel.segement == 0{
                        if self.viewModel.selectedWeek != nil{
                            IncomeExpensesHeader(viewData: self.viewModel.selectedWeek!)
                        }
                        
                        IncomeGraphView(viewModel: self.viewModel, viewData: self.viewModel.weekData).padding(.top)
                    }
                    else if self.viewModel.segement == 1{
                        if self.viewModel.selectedBiMonth != nil{
                            IncomeExpensesHeader(viewData: self.viewModel.selectedBiMonth!)
                        }
                        IncomeGraphView(viewModel: self.viewModel, viewData: self.viewModel.biMonthData).padding(.top)

                    }
                    else{
                        if self.viewModel.selectedMonth != nil{
                            IncomeExpensesHeader(viewData: self.viewModel.selectedMonth!)
                        }
                        IncomeGraphView(viewModel: self.viewModel, viewData: self.viewModel.monthData).padding(.top)
                    }
                    
                }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 5)
                
            }
        }
        
        
        
    }
}
