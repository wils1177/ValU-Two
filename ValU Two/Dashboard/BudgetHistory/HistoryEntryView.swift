//
//  HistoryEntryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoryEntryView: View {
    
    var budget : Budget
    var service : BudgetStatsService
    
    func getTitle() -> String{
        return CommonUtils.getMonthFromDate(date: self.budget.startDate!)
    }
    
    func getSpent() -> String{
        return "$" + String(Int(self.budget.spent))
    }
    
    func getReminaing() -> String{
        return "$" + String(Int(self.budget.getAmountAvailable() - self.budget.spent))
    }
    
    func getPercentage() -> Float{
        return self.budget.spent / self.budget.getAmountAvailable()
    }
    
    func getStartDate() -> String{
        let date = self.budget.startDate!
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df.string(from: date)
    }
    
    func getEndDate() -> String{
        let date = self.budget.endDate!
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df.string(from: date)
    }
    
    func getIcon() -> some View{
        if self.service.didHitSavingsGoal(budget: self.budget){
            return AnyView(Image(systemName: "checkmark.circle.fill").font(.system(size: 35)).padding(.trailing, 10).foregroundColor(Color(.systemGreen)))
        }
        else{
            return AnyView(Image(systemName: "xmark.shield.fill").font(.system(size: 35)).padding(.trailing, 10).foregroundColor(Color(.systemGray)))
        }
    }
        

    var body: some View {
        
        VStack(spacing: 0){
            HStack{
                Text(getTitle()).font(.headline)
                Text(getStartDate()).font(.footnote).foregroundColor(Color(.lightGray))
                Text("-").font(.footnote).foregroundColor(Color(.lightGray))
                Text(getEndDate()).font(.footnote).foregroundColor(Color(.lightGray))
                Spacer()
            }.padding(.bottom, 10)
            HStack{
                getIcon()
                
                VStack(alignment: .leading){
                    HStack(alignment: .bottom){
                        Text("$200").font(.title).bold()
                        Text("Saved").font(.headline).foregroundColor(Color(.lightGray)).padding(.bottom, 4)
                        Spacer()
                    }
                    
                    Text("You beat your savings goal!").font(.footnote).foregroundColor(Color(.gray))
                }
                Spacer()
            }.padding(.leading, 10)
        }.padding().background(Color(.white)).cornerRadius(15).padding(.bottom, 15).padding(.horizontal, 10)
        
        
        
    }
}


