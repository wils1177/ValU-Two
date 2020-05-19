//
//  IncomeCardView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeCardView: View {
    
    @State var pickerOptions = ["Monthly", "Semi-Monthly", "Weekly"]
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
        VStack(alignment: .leading){
            HStack{
                Text("Income vs Expenses").font(.title).bold()
                Spacer()
            }.padding(.top , 5)
            Text(self.pickerOptions[self.viewModel.segement]).foregroundColor(Color(.lightGray)).bold()
        }
        
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
                    
                    self.picker.padding(.horizontal).padding(.bottom)
                    //self.timeFrameTitle.padding(.horizontal).padding(.bottom)
                    
                    
                    if self.viewModel.segement == 0{
                        if self.viewModel.selectedMonth != nil{
                            HStack{
                                IncomeExpensesHeader(viewData: self.viewModel.selectedMonth!)
                                Spacer()
                            }
                            
                        }
                        else{
                            self.timeFrameTitle
                        }
                        
                        IncomeGraphView(viewModel: self.viewModel, viewData: self.viewModel.monthData)
                    }
                    else if self.viewModel.segement == 1{
                        if self.viewModel.selectedBiMonth != nil{
                            HStack{
                                IncomeExpensesHeader(viewData: self.viewModel.selectedBiMonth!)
                                Spacer()
                            }
                            
                        }
                        else{
                            self.timeFrameTitle
                        }
                        IncomeGraphView(viewModel: self.viewModel, viewData: self.viewModel.biMonthData)

                    }
                    else{
                        if self.viewModel.selectedWeek != nil{
                            HStack{
                                IncomeExpensesHeader(viewData: self.viewModel.selectedWeek!)
                                Spacer()
                            }
                            
                        }
                        else{
                            self.timeFrameTitle
                        }
                        IncomeGraphView(viewModel: self.viewModel, viewData: self.viewModel.weekData)
                    }
                    
                }
                
            }
        }
        
        
        
    }
}
