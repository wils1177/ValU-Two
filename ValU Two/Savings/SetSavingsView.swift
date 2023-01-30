//
//  SetSavingsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI
import SlidingRuler

struct SetSavingsView: View {
    
    var presentor : SetSavingsPresentor
    
    @State var textText: String = "$500"
    
    
    @State var savingsPercentage : Double
    
    @State private var value: Double = 0.0
    
    var scalingFactor = 0.5
   
    init(presentor: SetSavingsPresentor){
        self.presentor = presentor
        _savingsPercentage = State(initialValue: Double(presentor.budget.savingsPercent))
                
    }
    
    
    func getSavings() -> String{
        
        let ratio = (Double(self.presentor.budget.amount) * (self.savingsPercentage))
        let integer = Int(ratio)
        return CommonUtils.makeMoneyString(number: integer)
        
    }
    
    func getSpending() -> String{
        
        let ratio = (Double(self.presentor.budget.amount) * (1.0 - (self.savingsPercentage)))
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
    
    
    var title: some View{
        VStack(alignment: .center, spacing: 10){
            //Text(self.header).font(.system(size: 15, design: .rounded)).bold().lineLimit(3).multilineTextAlignment(.leading).foregroundColor(Color(.lightGray))
                
            Text("Enter a Savings Goal").font(.system(size: 27, design: .rounded)).fontWeight(.heavy).lineLimit(1).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)

            Text("Choose a percentage of your income to allocate towards savings.").font(.system(size: 16, design: .rounded)).lineLimit(3).multilineTextAlignment(.center).foregroundColor(Color(.gray))
        }.offset(y: -12)
    }
    
    var enterSavingsGoal: some View{
        Text(getSavings()).font(.system(size: 60, weight: .semibold, design: .rounded)).multilineTextAlignment(.center).foregroundColor(Color(.systemGreen))
    }
    
    var percentageBar: some View{
        
        HStack{
            Rectangle().foregroundColor(Color(.systemGreen))
            Rectangle().foregroundColor(Color(.systemRed))
        }.frame(height: 35).cornerRadius(25)
        
    }
    
    var confirmationButton: some View{
        Button(action: {
                      //Button Action
            
            self.presentor.budget.savingsPercent = Float(self.savingsPercentage)
            self.presentor.userPressedContinue()
            
                      }){
                          ActionButtonLarge(text: "Done", enabled: true, color: Color(.systemGreen)).padding().padding(.horizontal)
                          
                          
        
                  }
    }
    
    var spendingAmount: some View{
        
        HStack{
            Image(systemName: "info.circle.fill").font(.system(size: 16, weight: .semibold, design: .rounded)).foregroundColor(Color(.systemRed))
            Text(getSpending() + " Available to Spend").font(.system(size: 16, weight: .bold, design: .rounded)).lineLimit(3).multilineTextAlignment(.center).foregroundColor(Color(.systemRed))
        }
        
    }
    
    private var formatter: NumberFormatter {
            let f = NumberFormatter()
            f.numberStyle = .percent
            f.maximumFractionDigits = 0
            return f
        }
    
    
    var savingsGoals: some View{
        Text("test")
    }
    
    var body: some View {


        VStack{
                
            
            self.title.padding(.horizontal)
            
            spendingAmount.padding(.top, 20).padding(.bottom, 5)
            enterSavingsGoal
            
            
            
            
            //HorizontalSetSavingsSlider(presentor: self.presentor, savingPercentage: self.$savingsPercentage, scalingFactor: 1.0).frame(height: 40).padding(.top, 90).padding(.horizontal, 35)
            
            //LinesSetSavingsSlider(savingPercentage: self.$savingsPercentage)
            
            SlidingRuler(value: $savingsPercentage, in: 0...1, step: 0.1, snap: .fraction, tick: .fraction,
                         formatter: formatter).padding(.top, 80)
            
            Spacer()
            
            confirmationButton
            
            
            }
        
        .navigationBarTitle(Text(""))
        
}



}
