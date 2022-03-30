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
    
    func getDaysLeftIn() -> String{
        
        let date = Date()
        let endDate = self.budget.endDate!
        
        let diffInDays = Calendar.current.dateComponents([.day], from: date, to: endDate).day
        
        return String(diffInDays!) + " Days Left"
        
    }
    
    func getToday() -> String{
        let monthInt = Calendar.current.component(.month, from: Date()) // 4
        let monthStr = Calendar.current.monthSymbols[monthInt-1]  // April
        
        let dayInt = Calendar.current.component(.day, from: Date()) // 4
        let dayStr = String(dayInt)  // April
        
        return monthStr + " " + dayStr
        
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
                Text(self.getToday()).font(.system(size: 24, design: .rounded)).fontWeight(.semibold)
                Spacer()
                
                
                HStack(alignment:.center, spacing: 2){
                    Text(self.getDaysLeftIn()).font(Font.system(size: 16, weight: .semibold))
                    
            }.foregroundColor(AppTheme().themeColorPrimary)
                .padding(.horizontal, 13).padding(.vertical, 5).background(AppTheme().themeColorPrimary.opacity(0.15)).cornerRadius(20)
                
                
                
            }
        }.buttonStyle(PlainButtonStyle())

        
    }
    
    
    var differentView: some View{
        
        VStack(spacing: 0){
            
            
            /*
            HStack{
                Text("Time").font(.system(size: 21, design: .rounded)).fontWeight(.semibold)
                Spacer()
                
             
                
            }.padding(.horizontal, 13).padding(.top, 10)//.background(Color(AppTheme().themeColorPrimaryUIKit).opacity(0.35))
            */
            VStack(spacing: 0){
                
                HStack{
                    Text(self.getToday()).font(.system(size: 24, design: .rounded)).fontWeight(.semibold)
                    Spacer()
                    
                    
                    HStack(alignment:.center, spacing: 2){
                        Text(self.getDaysLeftIn()).font(Font.system(size: 16, weight: .semibold))
                        
                }.foregroundColor(AppTheme().themeColorPrimary)
                    .padding(.horizontal, 13).padding(.vertical, 5).background(AppTheme().themeColorPrimary.opacity(0.15)).cornerRadius(20)
                    
                    
                    
                }
                
                
            }
            
            
            
            
            
            
            
            
            
        }
        
    }
    
    
 
    
    

    
    var body: some View {
            differentView
            
           
            
        
        
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
        }.padding(10).frame(minWidth: 90).background(AppTheme().themeColorPrimary).cornerRadius(18)
    }
    
}


