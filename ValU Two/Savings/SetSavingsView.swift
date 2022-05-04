//
//  SetSavingsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SetSavingsView: View {
    
    var presentor : SetSavingsPresentor
    
    
    @State var savingsPercentage : Double
    
    var scalingFactor = 0.5
   
    init(presentor: SetSavingsPresentor){
        self.presentor = presentor
        _savingsPercentage = State(initialValue: Double(presentor.budget.savingsPercent / Float(scalingFactor)))
                
    }
    
    
    func getSavings() -> String{
        
        let ratio = (Double(self.presentor.budget.amount) * (self.savingsPercentage * scalingFactor))
        let integer = Int(ratio)
        return CommonUtils.makeMoneyString(number: integer)
        
    }
    
    func getSpending() -> String{
        
        let ratio = (Double(self.presentor.budget.amount) * (1.0 - (self.savingsPercentage  * scalingFactor)))
        let integer = Int(ratio)
        return CommonUtils.makeMoneyString(number: integer)
        
    }
 
    
    var topSummary : some View {
        HStack{
            Spacer()
            VStack(alignment: .leading, spacing: 3){
                HStack{
                    
                    Text("Savings").font(.system(size: 16, design: .rounded)).foregroundColor(Color(.lightGray)).bold()
                }
                
                Text(getSavings()).font(.system(size: 30, design: .rounded)).foregroundColor(Color(.systemGreen)).fontWeight(.heavy)
                
                
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 3){
                HStack{
                    
                    Text("Spending").font(.system(size: 16, design: .rounded)).foregroundColor(Color(.lightGray)).bold()
                }
                Text(getSpending()).font(.system(size: 30, design: .rounded)).foregroundColor(Color(.systemRed)).fontWeight(.heavy)
                
            }
            Spacer()
        }
    }
    
    
    var body: some View {


        VStack{
                
            topSummary.padding(.top)
            SetSavingsSlider(presentor: self.presentor, savingPercentage: self.$savingsPercentage, scalingFactor: self.scalingFactor).padding(.horizontal)
            
                
                
            
            
            
            
            Spacer()
            
            /*
            Button(action: {
                self.presentor?.userPressedContinue()
            }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Confirm").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    Spacer()
                }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
                
                
            }
            */
            
            }
        
        .navigationBarTitle(Text("Savings Goal")).navigationBarItems(
                                                                       
                                                                       
                    trailing: Button(action: {
                        //action
                        self.presentor.budget.savingsPercent = Float(self.savingsPercentage * scalingFactor)
                        self.presentor.userPressedContinue()
                        
                    }){
                    NavigationBarTextButton(text: "Done")
            })
        
}



}
