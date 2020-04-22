//
//  FutureBudgetsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/8/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct FutureBudgetsView: View {
    
    var timeFrames: [BudgetTimeFrame]
    @ObservedObject var viewModel: BudgetsViewModel
    
    func getTitle(date: Date) -> String{
        return CommonUtils.getMonthYear(date: date)
    }
    

    
    
    var body: some View {
        List{
            VStack(spacing: 0){
            
            ForEach(self.timeFrames, id: \.self) { timeFrame in
                VStack{
                    HStack{
                        Text(self.getTitle(date: timeFrame.startDate!)).font(.headline).bold()
                        Spacer()
                        
                        FutureBudgetActionBar(timeFrame: timeFrame, viewModel: self.viewModel)
                        
                        
                        
                    }.padding(.horizontal)
                    Divider().padding(.bottom)
                    
                    if timeFrame.budget == nil{
                        HStack{
                            Text("This time frame will carry over your budget from the previous month.").font(.headline).foregroundColor(Color(.lightGray))
                            Spacer()
                        }.padding(.horizontal).padding(.bottom)
                    }
                    else{
                        FutureEntryView(budget: timeFrame.budget!).padding(.bottom)
                    }
                    
                }.padding(.top)
                
                    
                //VStack(spacing: 0){
                //        FutureEntryView(budget: budget)
                //}
            }
        }
        
            
            
            
            
        }.navigationBarTitle("Upcomming")
    }
}


