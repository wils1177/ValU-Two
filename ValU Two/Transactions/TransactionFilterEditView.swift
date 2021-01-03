//
//  TransactionFilterEditView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionFilterEditView: View {
    var filterModel : TransactionFilterModel
    
    
    var timeFiltersView : some View {
        
        HStack{
            
            
            TimeFilterButton(number: "1", timeFrame: "Week", timeFilter: TimeFilters.lastWeek, filterModel: self.filterModel).padding(.horizontal, 5)
            
            TimeFilterButton(number: "1", timeFrame: "Month", timeFilter: TimeFilters.last30Days, filterModel: self.filterModel).padding(.horizontal, 5)
            
            
        }
        
    }
    
    var directionFiltersView : some View {
        
        HStack{
            
            
            DirectionFilterButton(name: "Income", directionFilter: DirectionFilter.income, filterModel: self.filterModel).padding(.horizontal, 5)
            
            DirectionFilterButton(name: "Expense", directionFilter: DirectionFilter.expense, filterModel: self.filterModel).padding(.horizontal, 5)
            
            
        }
        
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        Text("Time").font(.title2).bold()
                        Spacer()
                    }
                    
                    timeFiltersView.padding(.leading)
                    
                }.padding(.horizontal).padding(.top)
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Transaction Flow").font(.title2).bold()
                        Spacer()
                    }
                    
                    directionFiltersView.padding(.leading)
                    
                }.padding(.horizontal).padding(.top)
                
                
            }
            .navigationBarTitle("Edit Filters", displayMode: .large)
            
        }
    }
}


struct TimeFilterButton : View {
    
    var number : String
    var timeFrame: String
    var timeFilter : TimeFilters
    @ObservedObject var filterModel : TransactionFilterModel
    
    
    func getButtonColor() -> Color {
        if filterModel.timeFilter == timeFilter{
            
            return AppTheme().themeColorPrimary
        }
        else{
            return .clear
        }
    }
    
    var body: some View {
        
        
        Button(action: {
            // What to perform
            self.filterModel.changeTimeFilterTo(time: self.timeFilter)
        }) {
            ZStack(alignment: .center){
                Circle().frame(width: 75, height: 75, alignment: .center).foregroundColor(Color(.systemGroupedBackground))
                
                VStack{
                    Text(number).bold()
                    Text(timeFrame).font(.subheadline)
                }
                
            }.overlay(
                Circle()
                    .stroke(self.getButtonColor(), lineWidth: 3)
                ).padding(.horizontal, 2)
        }.buttonStyle(PlainButtonStyle())
        
        
        
    }
    
}


struct DirectionFilterButton : View {
    
    var name : String
    var directionFilter : DirectionFilter
    @ObservedObject var filterModel : TransactionFilterModel
    
    
    func getButtonColor() -> Color {
        if filterModel.directionFilter == directionFilter{
            
            return AppTheme().themeColorPrimary
        }
        else{
            return .clear
        }
    }
    
    var body: some View {
        
        
        Button(action: {
            // What to perform
            self.filterModel.changeDirectionFilterTo(filter: self.directionFilter)
        }) {
            ZStack(alignment: .center){
                Capsule().frame(width: 90, height: 30, alignment: .center).foregroundColor(Color(.systemGroupedBackground))
                
                VStack{
                    Text(name).bold()
                }
                
            }.overlay(
                Capsule()
                    .stroke(self.getButtonColor(), lineWidth: 3)
                ).padding(.horizontal, 2)
        }.buttonStyle(PlainButtonStyle())
        
        
        
    }
    
}


