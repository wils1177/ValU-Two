//
//  TransactionsFilterView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI


struct SelectedFilterPillsView: View {
    
    @ObservedObject var filterModel : TransactionFilterModel
    
    var timePill : some View{
        VStack{
            
            if filterModel.timeFilter?.type == TimeFilters.lastWeek{
                TimeFilterPill(filterModel: self.filterModel, name: "THIS WEEK", action: self.filterModel.changeTimeFilterTo)
                
            }
            else if filterModel.timeFilter?.type == TimeFilters.last30Days{
                
                
                
                TimeFilterPill(filterModel: self.filterModel, name: "THIS MONTH", action: self.filterModel.changeTimeFilterTo)
                
                
            }
            else if filterModel.timeFilter?.type == TimeFilters.previous30Days{
                
                
                
                TimeFilterPill(filterModel: self.filterModel, name: "LAST MONTH", action: self.filterModel.changeTimeFilterTo)
                
                
            }
            else if filterModel.timeFilter?.type == TimeFilters.previousWeek{
                
                
                
                TimeFilterPill(filterModel: self.filterModel, name: "LAST WEEK", action: self.filterModel.changeTimeFilterTo)
                
                
            }
            else if filterModel.timeFilter?.type == TimeFilters.custom{
                TimeFilterPill(filterModel: self.filterModel, name: CommonUtils.getMonthDayString(date: filterModel.timeFilter!.startDate!) + " - " + CommonUtils.getMonthDayString(date: filterModel.timeFilter!.endDate!), action: self.filterModel.changeTimeFilterTo)
            }
            
        }
    }
    
    var directionPill : some View {
        VStack{
            if filterModel.directionFilter == DirectionFilter.income{
                DirectionFilterPill(filterModel: self.filterModel, name: "INCOME", action: self.filterModel.changeDirectionFilterTo)
                
            }
            else if filterModel.directionFilter == DirectionFilter.expense{
                DirectionFilterPill(filterModel: self.filterModel, name: "EXPENSES", action: self.filterModel.changeDirectionFilterTo)
                
            }
        }
    }
    
    var categoryPill : some View{
        
        HStack{
            
            if filterModel.categoryFilters.count > 0 {
                
                Button(action: {
                    //self.action(nil, nil, nil)
                    self.filterModel.clearCategoryFilter()
                }) {
                    HStack{
                        Image(systemName: "xmark.circle.fill").foregroundColor(globalAppTheme.themeColorPrimary)
                        
                        ForEach(filterModel.categoryFilters, id: \.self) { category in
                            Text(category.icon!).foregroundColor(globalAppTheme.themeColorPrimary).font(.subheadline)
                            
                            
                    }
                    }
                    
                
                
                }.buttonStyle(PlainButtonStyle()).padding(.horizontal, 4).padding(.trailing, 5).padding(.vertical, 5).background(globalAppTheme.themeColorPrimary.opacity(0.1)).cornerRadius(15)
            }
            
        }
        
    }
    
    var body: some View {
        HStack{
            timePill.padding(.horizontal, 3)
            directionPill.padding(.horizontal, 3)
            categoryPill.padding(.horizontal, 3)
            Spacer()
        }
    }
    
}




struct TimeFilterPill: View {
    
    @ObservedObject var filterModel : TransactionFilterModel
    var name : String
    
    var action : (TimeFilters?, Date?, Date?) -> ()
    
    var body: some View {
        HStack{

            Button(action: {
                self.action(nil, nil, nil)
            }) {
                Image(systemName: "xmark.circle.fill").foregroundColor(globalAppTheme.themeColorPrimary)
            }.buttonStyle(PlainButtonStyle())
            
            
            Text(self.name).foregroundColor(globalAppTheme.themeColorPrimary).font(.subheadline).bold()
        }.padding(.horizontal, 4).padding(.trailing, 5).padding(.vertical, 5).background(globalAppTheme.themeColorPrimary.opacity(0.1)).cornerRadius(15)
    }
}


struct DirectionFilterPill: View {
    
    @ObservedObject var filterModel : TransactionFilterModel
    var name : String
    
    var action : (DirectionFilter?) -> ()
    
    var body: some View {
        HStack{

            Button(action: {
                self.action(nil)
            }) {
                Image(systemName: "xmark.circle.fill").foregroundColor(globalAppTheme.themeColorPrimary)
            }.buttonStyle(PlainButtonStyle())
            
            
            Text(self.name).foregroundColor(globalAppTheme.themeColorPrimary).font(.subheadline).bold()
        }.padding(.horizontal, 4).padding(.trailing, 5).padding(.vertical, 5).background(globalAppTheme.themeColorPrimary.opacity(0.1)).cornerRadius(15)
    }
}

