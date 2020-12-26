//
//  SetSavingsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SetSavingsView: View {
    
    @ObservedObject var viewData : SetSavingsViewData
    var presentor : SetSavingsPresentor?
    
    
    var goodMessageIcon = "👌"
    var goodMessage = "That's a great goal!"
    
    var badMessageIcon = "❗"
    var badMessage = "Your goal is a bit low!"
    
    var tooMuchIcon = "🥵"
    var tooMuchMessage = "Keepj enough money for expenses!"
    
   
    init(presentor: SetSavingsPresentor?, viewData: SetSavingsViewData){
        self.viewData = viewData
        self.presentor = presentor
                
    }
    
    func getRecMessage() -> String {
        
        if self.viewData.savingsPercentage < 0.20{
            return badMessage
        }
        else if self.viewData.savingsPercentage > 0.6{
            return tooMuchMessage
        }
        else{
            return goodMessage
        }
        
    }
    
    func getRecIcon() -> String {
        
        if self.viewData.savingsPercentage < 0.20{
            return badMessageIcon
        }
        else if self.viewData.savingsPercentage > 0.6{
            return tooMuchIcon
        }
        else{
            return goodMessageIcon
        }
        
    }
    
    
    var reccomendation: some View{
        VStack{
            /*
            HStack{
                Spacer()
                Text(getRecIcon()).font(.largeTitle)
                Text(getRecMessage()).font(.headline)
                Spacer()
            }.transition(.scale)
            */
            HStack{
                Text("Experts reccomend saving at least 20% of your income.").font(.subheadline).foregroundColor(Color(.gray)).multilineTextAlignment(.center)
            }.padding(.horizontal).padding(.horizontal)
            
            
        }
        
    }
    
    var topSummary : some View {
        HStack{
            Spacer()
            VStack(spacing: 3){
                HStack{
                    Image(systemName: "plus.circle").foregroundColor(Color(.systemGreen))
                    Text("SAVINGS").font(.subheadline).foregroundColor(Color(.systemGreen)).bold()
                }
                
                Text("$\(self.viewData.savingsAmount)").font(.title).bold()
                
                
            }
            
            Spacer()
            
            VStack(spacing: 3){
                HStack{
                    Image(systemName: "minus.circle").foregroundColor(Color(.systemRed))
                    Text("SPENDING").font(.subheadline).foregroundColor(Color(.systemRed)).bold()
                }
                Text("$\(self.viewData.spendingAmount)").font(.title).bold()
                
            }
            Spacer()
        }
    }
    
    
    var body: some View {


        VStack{
                
            topSummary.padding(.top)
            SetSavingsSlider(viewData: self.viewData, presentor: self.presentor).padding(.horizontal)
            reccomendation
                //self.indicator.offset(y: -((CGFloat(0.20) * geometry.size.height) - (geometry.size.height/2)))
                
                
            
            
            
            
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
            
            }.navigationBarTitle(Text("Savings Goal")).navigationBarItems(
                                                                       
                                                                       
                    trailing: Button(action: {
                        //action
                        self.presentor?.userPressedContinue()
                    }){
                    Text("Done").bold()
            })
        
}

struct SetSavingsView_Previews: PreviewProvider {
    static var previews: some View {
        SetSavingsView(presentor: nil, viewData: SetSavingsViewData(savingsAmount: "500", spendingAmount: "500", savingsPercentage: 0.5))
    }
}

}
