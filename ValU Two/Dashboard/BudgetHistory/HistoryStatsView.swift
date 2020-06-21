//
//  HistoryStatsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoryStatsView: View {
    
    var service : BudgetStatsService
    
    var body: some View {
        
        VStack{
            HStack{
                
                HStack{
                    Spacer()
                    VStack{
                    
                    Text("Money Saved").font(.caption)
                        Text("$" + String(self.service.getTotalAmountSaved())).font(.largeTitle).foregroundColor(Color(.systemGreen)).fontWeight(.semibold).padding(.top, 10)
                    Text("Saved")
                    }
                    Spacer()
                }.padding(10).background(Color(.white)).cornerRadius(15).padding(.trailing, 10)
                
                HStack{
                    Spacer()
                    VStack{
                    
                    Text("Budgets").font(.caption)
                        Text(String(self.service.getCompletedBudgets())).font(.largeTitle).foregroundColor(AppTheme().themeColorPrimary).fontWeight(.semibold).padding(.top, 10)
                    Text("Completed")
                    }
                    Spacer()
                }.padding(10).background(Color(.white)).cornerRadius(15).padding(.leading, 10)
                

            }.padding(.bottom)
            
            /*
            HStack{
                
                HStack{
                    Spacer()
                    VStack{
                    
                    Text("Savings Goals").font(.caption)
                    Text(String(self.service.getSavingsGoalsHit())).font(.largeTitle).foregroundColor(Color(.systemGreen)).fontWeight(.semibold).padding(.top, 10)
                    Text("Succeeded")
                    }
                    Spacer()
                }.padding(10).background(Color(.white)).cornerRadius(15).padding(.trailing, 10)
                
                HStack{
                    Spacer()
                    VStack{
                    
                    Text("Savings Goals").font(.caption)
                        Text(String(self.service.getSavingsGoalsMissed())).font(.largeTitle).foregroundColor(Color(.systemRed)).fontWeight(.semibold).padding(.top, 10)
                    Text("Missed")
                    }
                    Spacer()
                }.padding(10).background(Color(.white)).cornerRadius(15).padding(.leading, 10)
                

            }
            */
        }
        
    }
}

