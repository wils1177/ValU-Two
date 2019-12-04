//
//  IncomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/15/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EnterIncomeView: View {
    
    
    @ObservedObject var viewData: EnterIncomeViewData
    var presentor : EnterIncomePresentor?
    
    init(presentor: EnterIncomePresentor?, viewData : EnterIncomeViewData){
        self.presentor = presentor
        self.viewData = viewData
    }
    
    var body: some View {
        
        VStack(alignment: .center){
            
            
            VStack{
                Text("Here is a lot of text about entering yout incomr and why").lineLimit(nil).multilineTextAlignment(.center).padding()
                
                
                
            }.padding()
            
            Spacer()
            VStack{
                TextField("Your Income", text: $viewData.incomeAmountText).textFieldStyle(PlainTextFieldStyle()).font(.title).multilineTextAlignment(.center)
                .padding()
                
                Button(action: {
                    
                }){
                    ZStack{
                        Text("Guess for me!").font(.subheadline).foregroundColor(.white).bold().padding()
                    }.background(Color(.purple)).cornerRadius(30).shadow(radius: 10).padding()
                    
                }
            }
            Spacer()
            
            
            
            
            
            Button(action: {
                self.presentor?.userSelectedCTA()
            }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Continue").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    Spacer()
                }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
                
                
            }
            
            
            }.navigationBarTitle(Text("Enter Your Income"))
        
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterIncomeView(presentor: nil, viewData: EnterIncomeViewData(timeFrameIndex: 0, incomeAmountText: ""))
    }
}
