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
    
    
    
   
    init(presentor: SetSavingsPresentor?, viewData: SetSavingsViewData){
        self.viewData = viewData
        self.presentor = presentor
                
    }
    
    
    var reccomendation: some View{
        VStack(alignment: .leading){

            HStack{
                Text("Try staring with 20% of your income.").foregroundColor(Color(.lightGray))
                Spacer()
                Button(action: {
                    //action
                    print("bruh")
                    self.presentor?.try20()
                }){
                    Text("Try it").bold()
                }
            }
            
        }.padding(10).padding(.horizontal)
    }
    
    
    var body: some View {


        VStack{
                
                //reccomendation
                SetSavingsSlider(viewData: self.viewData, presentor: self.presentor)
                
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
