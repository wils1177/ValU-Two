//
//  LimitSliderView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/5/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct LimitSliderView: View {
    
    @State var sliderPosition = CGFloat(0.0)
    
    //var categoryName : String
    //var percentage : Float
    //var amount : String
    
    @ObservedObject var viewCategory : ViewCategory
    
    var presentor : SetSpendingPresentor?
    
    init(presentor: SetSpendingPresentor?, viewCategory : ViewCategory){
        self.presentor = presentor
        self.viewCategory = viewCategory

    }
    
    
        
    
    var body: some View {
        
        VStack{
            
            HStack{
                Text(self.viewCategory.name).font(.headline).bold()
                Spacer()
                
            }.padding(.horizontal).padding(.top)
            
            HStack{
                Text("$").font(.largeTitle)
                
                
                TextField("", text: self.$viewCategory.limit).textFieldStyle(PlainTextFieldStyle()).font(.largeTitle)
                
                
                
                
                Spacer()
                
                VStack{
                    if self.viewCategory.limit != "0"{
                        Stepper("Spending Limit:", onIncrement: {
                            print("up")
                            self.presentor?.incrementCategory(categoryName: self.viewCategory.name, incrementAmount: 10)
                        }, onDecrement: {
                            print("down")
                            self.presentor?.incrementCategory(categoryName: self.viewCategory.name, incrementAmount: -10)
                        }).labelsHidden()
                    }

                    else{
                        Stepper("Spending Limit:", onIncrement: {
                            print("up")
                            self.presentor?.incrementCategory(categoryName: self.viewCategory.name, incrementAmount: 10)
                        }, onDecrement: nil).labelsHidden()
                    }
                }
                
                
                
                
                
            }.padding(.horizontal)
            
            HStack{
                Text("You spent $200 in the last month").font(.body).padding(.bottom)
                Spacer()
            }.padding(.horizontal)
            
            
        }.background(LinearGradient(gradient:  Gradient(colors: [.white, .white]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(10).shadow(radius: 10)
        
        
    }
}


struct LimitSliderView_Previews: PreviewProvider {
    static var previews: some View {
        LimitSliderView(presentor: nil, viewCategory: ViewCategory(name: "testing", limit: "500"))
    }
}



