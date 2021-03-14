//
//  CalendarView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/8/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI



struct CalendarView: View {
    
    @ObservedObject var budget: Budget
    @State var isLarge  : Bool = false
    
    var viewModel : TimeSectionViewModel
    
    var coordinator: BudgetsTabCoordinator?
    
    init(budget : Budget, service: BudgetTransactionsService, coordinator: BudgetsTabCoordinator?){
        self.budget = budget
        self.viewModel = TimeSectionViewModel(budget: budget, service: service)
        self.coordinator = coordinator
    }
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 13),
        GridItem(.flexible(), spacing: 13),
        GridItem(.flexible(), spacing: 13),
        GridItem(.flexible(), spacing: 13)
        //GridItem(.flexible(), spacing: 13),
        //GridItem(.flexible(), spacing: 13),
        //GridItem(.flexible(), spacing: 13)
        ]
    
    
    var body: some View {
        
        ScrollView{
            HStack{
                Text("Period: " + self.viewModel.startDate + " - " + self.viewModel.endDate).font(.system(size: 21, design: .rounded)).fontWeight(.semibold).foregroundColor(Color(.systemGray)).padding(.trailing).padding(.leading)
                Spacer()
            }.padding(.bottom, 10)
            
            
            LazyVGrid(      columns: columns,
                            alignment: .center,
                            spacing: 15,
                            pinnedViews: [.sectionHeaders, .sectionFooters]
            ){
                
                ForEach(self.viewModel.viewData.reversed(), id: \.self) { data in
                    
                    Button(action: {
                        // What to perform
                        self.coordinator?.showTransactionsForDate(title: data.dateName, date: data.date)
                    }) {
                        // How the button looks like
                        if data.future{
                            CalendarEntryView(dayName : data.dateName, color: data.color, amountName: data.amount).grayscale(0.99).opacity(0.5).padding(.horizontal, 3.5)
                        }
                        else{
                            CalendarEntryView(dayName : data.dateName, color: data.color, amountName: data.amount).padding(.horizontal, 3.5)
                        }
                        
                    }.buttonStyle(PlainButtonStyle())
                    
                }
                
            }.padding(.horizontal, 10)
            
        }.navigationTitle("Calendar")
        
        
        
    }
}

