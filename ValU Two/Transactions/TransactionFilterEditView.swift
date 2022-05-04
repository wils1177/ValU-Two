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
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var timeSelection : TimeFilters? = nil
    
    @State private var directionSelection : DirectionFilter? = nil
    
    var coordinator: TransactionsTabCoordinator?
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 11),
            GridItem(.flexible(), spacing: 11),
        GridItem(.flexible(), spacing: 11)
        ]
    
    var timeFiltersView : some View {
        
        HStack{
            
            TimeFilterEditSection(startDate: $startDate, endDate: $endDate, selection: $timeSelection)
            
            //TimeFilterButton(number: "This", timeFrame: "Week", timeFilter: TimeFilters.lastWeek, filterModel: self.filterModel).padding(.horizontal, 5)
            
            //TimeFilterButton(number: "This", timeFrame: "Month", timeFilter: TimeFilters.last30Days, filterModel: self.filterModel).padding(.horizontal, 5)
            
            
        }
        
    }
    
    var directionFiltersView : some View {
        
        ScrollView(.horizontal) {
            
            HStack{
                
                
                DirectionFilterButton(name: "Income", directionFilter: DirectionFilter.income, selectedDirectionFiler: self.$directionSelection).padding(.horizontal, 5)
                
                DirectionFilterButton(name: "Expense", directionFilter: DirectionFilter.expense, selectedDirectionFiler: self.$directionSelection).padding(.horizontal, 5)
                
                
            }
            
        }
        
        
        
    }
    
    var categories : some View{
        LazyVGrid(      columns: columns,
                        alignment: .center,
                        spacing: 10,
                        pinnedViews: [.sectionHeaders, .sectionFooters]
        ){
            
            ForEach(self.filterModel.spendingCategories, id: \.self){entry in
                
                EditCategoryRowView(category: entry, viewModel: self.filterModel)
                                
            }
        }.padding(.horizontal)
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        Text("Time").font(.system(size: 24, design: .rounded)).bold()
                        Spacer()
                    }.padding(.horizontal)
                    
                    timeFiltersView.padding(.leading)
                    
                }.padding(.top)
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Transaction Flow").font(.system(size: 24, design: .rounded)).bold()
                        Spacer()
                    }
                    
                    directionFiltersView
                    
                }.padding(.horizontal).padding(.top)
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Categories").font(.system(size: 24, design: .rounded)).bold()
                        Spacer()
                    }.padding(.horizontal)
                    
                    categories
                    
                }.padding(.top)
                
                
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Edit Filters", displayMode: .large)
            
            .navigationBarItems(leading:
                                    
                                    Button(action: {
                                        //print("what's up")
                                        
                                        
                                        self.coordinator?.dismiss()
                                        
                                    }){
                                    ZStack{
                                        
                                        NavigationBarTextButton(text: "Cancel")
                                        
                                    }
                                    }
                                    
                                    
                                    ,trailing:
            
            Button(action: {
                //print("what's up")
                self.filterModel.filtersSubmitted(time: self.timeSelection, start: self.startDate, end: self.endDate, direction: self.directionSelection)
                
                self.coordinator?.dismiss()
                
            }){
            ZStack{
                
                NavigationBarTextButton(text: "Done")
                
            }
            }
            
            
            
        )
            
        }
    }
}


struct TimeFilterEditSection : View{
    @Binding var startDate : Date
    @Binding var endDate : Date
    
    @Binding var selection : TimeFilters?
    
    var body : some View{
        VStack{
            ScrollView(.horizontal) {
                
                HStack{
                    
                    Button(action: {
                        // What to perform
                        withAnimation{
                            if self.selection != TimeFilters.custom{
                                self.selection = TimeFilters.custom
                            }
                            else{
                                self.selection = nil
                            }
                        }
                        
                    }) {
                        // How the button looks like
                        TimeFilterButton(number: "Custom", timeFrame: "Period", timeFilter: TimeFilters.custom, selectedFilter: self.$selection).padding(.horizontal, 5)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        // What to perform
                        if self.selection != TimeFilters.lastWeek{
                            self.selection = TimeFilters.lastWeek
                        }
                        else{
                            self.selection = nil
                        }
                        
                    }) {
                        // How the button looks like
                        TimeFilterButton(number: "This", timeFrame: "Week", timeFilter: TimeFilters.lastWeek, selectedFilter: self.$selection).padding(.horizontal, 5)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        // What to perform
                        if self.selection != TimeFilters.last30Days{
                            self.selection = TimeFilters.last30Days
                        }
                        else{
                            self.selection = nil
                        }
                    }) {
                        // How the button looks like
                        TimeFilterButton(number: "This", timeFrame: "Month", timeFilter: TimeFilters.last30Days, selectedFilter: self.$selection).padding(.horizontal, 5)
                    }.buttonStyle(PlainButtonStyle())
                    
                    
                    Button(action: {
                        // What to perform
                        if self.selection != TimeFilters.previousWeek{
                            self.selection = TimeFilters.previousWeek
                        }
                        else{
                            self.selection = nil
                        }
                    }) {
                        // How the button looks like
                        TimeFilterButton(number: "Last", timeFrame: "Week", timeFilter: TimeFilters.previousWeek, selectedFilter: self.$selection).padding(.horizontal, 5)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        // What to perform
                        if self.selection != TimeFilters.previous30Days{
                            self.selection = TimeFilters.previous30Days
                        }
                        else{
                            self.selection = nil
                        }
                    }) {
                        // How the button looks like
                        TimeFilterButton(number: "Last", timeFrame: "Month", timeFilter: TimeFilters.previous30Days, selectedFilter: self.$selection).padding(.horizontal, 5)
                    }.buttonStyle(PlainButtonStyle())
                    
                    
                    
                    
                    
                }
            }
            
            
            
            if selection == TimeFilters.custom{
                
                VStack{
                    DatePicker(selection: $startDate, in: ...Date(), displayedComponents: .date) {
                                    Text("Start Date")
                                }
                    
                    DatePicker(selection: $endDate, in: ...Date(), displayedComponents: .date) {
                                    Text("End date")
                                }
                }.padding(15).background(Color(.tertiarySystemBackground)).cornerRadius(20).padding(.horizontal).padding(.trailing)
                
                
                
            }
            
            
        }
        
    }
}


struct TimeFilterButton : View {
    
    var number : String
    var timeFrame: String
    var timeFilter : TimeFilters
    @Binding var selectedFilter : TimeFilters?
    
    
    func getButtonColor() -> Color {
        if selectedFilter == timeFilter{
            
            return AppTheme().themeColorPrimary
        }
        else{
            return .clear
        }
    }
    
    var body: some View {
        
        
        
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 24).frame(width: 85, height: 85, alignment: .center).foregroundColor(Color(.tertiarySystemBackground))
                
                VStack{
                    Text(number).bold()
                    Text(timeFrame).font(.subheadline)
                }
                
            }.overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(self.getButtonColor(), lineWidth: 3)
                ).padding( 3)
        
        
        
        
    }
    
}


struct DirectionFilterButton : View {
    
    var name : String
    var directionFilter : DirectionFilter
    @Binding var selectedDirectionFiler : DirectionFilter?
    
    
    func getButtonColor() -> Color {
        if selectedDirectionFiler == directionFilter{
            
            return AppTheme().themeColorPrimary
        }
        else{
            return .clear
        }
    }
    
    var body: some View {
        
        
        Button(action: {
            // What to perform
            if selectedDirectionFiler != directionFilter{
                self.selectedDirectionFiler = directionFilter
            }
            else{
                self.selectedDirectionFiler = nil
            }
        }) {
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 24).frame(width: 85, height: 85, alignment: .center).foregroundColor(Color(.tertiarySystemBackground))
                
                VStack{
                    Text(name).bold()
                }
                
            }.overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(self.getButtonColor(), lineWidth: 3)
                ).padding( 3)
        }.buttonStyle(PlainButtonStyle())
        
        
        
    }
    
}


