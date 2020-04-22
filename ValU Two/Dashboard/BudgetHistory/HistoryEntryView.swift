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
        

    var body: some View {
        VStack{
            HStack{
                Text(getTitle()).font(.title).fontWeight(.bold)
                Spacer()
            }
            HStack{
                
                HStack{
                    
                    //Spacer()
                    VStack{
                        Text(getSpent()).font(.system(size: 28)).fontWeight(.bold)
                        Text("Spent").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                    }
                    
                    
                }.padding(.leading).padding(.leading)

                Spacer()
                
                HStack{
                    
                    
                    VStack{
                        //Spacer()
                        Text(getReminaing()).font(.system(size: 28)).fontWeight(.bold)
                        Text("Saved").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                        
                    }
                    
                    
                }.padding(.trailing).padding(.trailing).padding(.top)
                
            }
            
        
            
            ProgressBarView(percentage: CGFloat(getPercentage()), color: Color(.black))
            
            
            
            
            
            
        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 8).padding(.leading).padding(.trailing).padding(.bottom)
    }
}


