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
            if filterModel.timeFilter == TimeFilters.lastWeek{
                TimeFilterPill(filterModel: self.filterModel, name: "LAST WEEK", action: self.filterModel.changeTimeFilterTo)
                
            }
            else if filterModel.timeFilter == TimeFilters.last30Days{
                
                TimeFilterPill(filterModel: self.filterModel, name: "LAST MONTH", action: self.filterModel.changeTimeFilterTo)
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
    
    var body: some View {
        HStack{
            timePill
            directionPill
            Spacer()
        }
    }
    
}


struct TimeFilterPill: View {
    
    @ObservedObject var filterModel : TransactionFilterModel
    var name : String
    
    var action : (TimeFilters?) -> ()
    
    var body: some View {
        HStack{

            Button(action: {
                self.action(nil)
            }) {
                Image(systemName: "xmark.circle.fill").foregroundColor(Color(.black))
            }.buttonStyle(PlainButtonStyle())
            
            
            Text(self.name).font(.caption)
        }.padding(.horizontal, 4).padding(.trailing, 5).padding(.vertical, 5).background(Color(.systemGray2)).cornerRadius(15)
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
                Image(systemName: "xmark.circle.fill").foregroundColor(Color(.black))
            }.buttonStyle(PlainButtonStyle())
            
            
            Text(self.name).font(.caption)
        }.padding(.horizontal, 4).padding(.trailing, 5).padding(.vertical, 5).background(Color(.systemGray2)).cornerRadius(15)
    }
}

