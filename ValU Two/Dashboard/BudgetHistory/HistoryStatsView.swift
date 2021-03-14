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
    
    @State var isLarge = false
    
    var body: some View {
        
        VStack(alignment: .center){
            
            HStack{
                VStack{
                    HStack{
                        Image(systemName: "rosette").font(.system(size: 21)).foregroundColor(Color(.systemGreen))
                        Text("Total Savings").font(.system(size: 18, design: .rounded)).fontWeight(.bold)
                        Spacer()
                    }
                
                    Text("$" + String(self.service.getTotalAmountSaved())).font(.system(size: 44, design: .rounded)).bold().foregroundColor(Color(.systemGreen)).fontWeight(.semibold).padding(.top, 10)
                    Text("Saved").font(.subheadline).bold().frame(maxWidth: 100)
                }
                Spacer()
            }.padding().background(Color(.tertiarySystemBackground)).cornerRadius(15).padding(.horizontal, 10).padding(.vertical, 5).shadow(radius: 10)
            
            HStack{
                VStack{
                    
                    HStack{
                        Image(systemName: "creditcard").font(.system(size: 21)).foregroundColor(AppTheme().themeColorPrimary)
                        Text("Budgets Completed").font(.system(size: 18, design: .rounded)).fontWeight(.bold)
                        Spacer()
                    }
                
                    Text(String(self.service.getCompletedBudgets())).font(.system(size: 44, design: .rounded)).bold().foregroundColor(AppTheme().themeColorPrimary).fontWeight(.semibold).padding(.top, 10)
                    Text("Budget(s)").font(.subheadline).bold().multilineTextAlignment(.center).frame(maxWidth: 100)
                }
                Spacer()
            }.padding().background(Color(.tertiarySystemBackground)).cornerRadius(15).padding(.horizontal, 10).padding(.vertical, 5).shadow(radius: 10)
            
            
            
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

