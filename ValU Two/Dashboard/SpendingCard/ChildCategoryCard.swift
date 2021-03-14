//
//  ChildCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ChildCategoryCard: View {
    
    var limit : Double
    var spent : Double
    var icon : String
    var name : String
    
    func getPercentage() -> Double{
        if self.limit != 0.0{
            return spent / limit
        }
        else{
            return 0.0
        }
    }
    
    var remainingText : some View{
        HStack{
            

                
                Text(CommonUtils.makeMoneyString(number: limit)).font(.system(size: 15)).bold().foregroundColor(Color(.gray)).lineLimit(1)
            Text ("budgeted" ).font(.system(size: 15)).bold().foregroundColor(Color(.gray))
            
            
            
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack(alignment: .center){
                Text(self.icon).font(.system(size: 40, design: .rounded)).padding(.trailing, 8)
                VStack(alignment: .leading, spacing: 4){
                    HStack{
                        
                        Text(self.name).font(.system(size: 20, design: .rounded)).bold().lineLimit(1)
                        Spacer()
                    }
                    
                    remainingText.padding(.trailing, 20)
                }
                
                Spacer()
                
                Text(CommonUtils.makeMoneyString(number: spent)).font(.system(size: 20, design: .rounded)).bold().padding(.trailing, 5)
                
            }
            
            
            
            
            //ProgressBarView(percentage: CGFloat(self.getPercentage()), color: colorMap[Int(budgetCategory.budgetSection!.colorCode)], width: 80, backgroundColor: Color(.white)).padding(.bottom).padding(.horizontal, 20).padding(.top)
            
            
            //Divider()
            
        }.padding(15).background(Color(.tertiarySystemBackground)).cornerRadius(15).shadow(radius: 5)
        
    }
}


