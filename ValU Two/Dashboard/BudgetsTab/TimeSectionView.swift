//
//  TimeSectionView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/11/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TimeSectionView: View {
    
    @ObservedObject var budget: Budget
    @State var isLarge  : Bool = false
    
    
    var coordinator: BudgetsTabCoordinator?
    
    init(budget : Budget, service: BudgetTransactionsService, coordinator: BudgetsTabCoordinator?){
        self.budget = budget
        self.coordinator = coordinator
    }
    
    var headerView : some View{
        
        Button(action: {
            // What to perform
            //withAnimation{
                //self.isLarge.toggle()
            //}
            self.coordinator?.showCalendar()
        }) {
            HStack{
                SectionHeader(title: "January 21st", image: "calendar")
                Spacer()
                
                
                HStack(alignment:.center, spacing: 2){
                    Text("23 Days Left").font(Font.system(size: 16, weight: .semibold))
                    
            }.foregroundColor(AppTheme().themeColorPrimary)
                .padding(.horizontal, 13).padding(.vertical, 5).background(AppTheme().themeColorPrimary.opacity(0.15)).cornerRadius(20)
                
                /*
                if !isLarge{
                    Text(self.viewModel.getDaysRemaining() + " days left").font(.system(size: 22, design: .rounded)).fontWeight(.semibold).padding(.trailing)
                }
                
                
                Image(systemName: "chevron.right").font(.system(size: 20)).foregroundColor(AppTheme().themeColorPrimary).rotationEffect(.degrees(isLarge ? 90 : 0))
                */
                
            }.padding(.horizontal, 10)
        }.buttonStyle(PlainButtonStyle())

        
    }
    
    
 
    
    

    
    var body: some View {
        VStack{
            headerView
            
           
            
        }
        
    }
}

struct CalendarEntryView: View {
    
    var dayName: String
    var color: Color
    var amountName : String
    
    var body : some View{
        VStack{
            Text(self.dayName).font(.system(size: 16, design: .rounded)).fontWeight(.bold).padding(.bottom, 3)
            
            Text(amountName).font(.system(size: 25, design: .rounded)).fontWeight(.bold).foregroundColor(self.color).padding(.bottom, 3)
        }.padding(10).frame(minWidth: 90).background(Color(.tertiarySystemGroupedBackground).opacity(0.55)).cornerRadius(18)
    }
    
}


