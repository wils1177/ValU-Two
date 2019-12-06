//
//  SetSavingsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SetSavingsView: View {
    
    @State var sliderPosition = CGFloat(0.0)
    @ObservedObject var viewData : SetSavingsViewData
    var presentor : SetSavingsPresentor?
    
    func getHeight(viewHeight : CGFloat) -> CGFloat{
        
        let height = (viewHeight / 2) + sliderPosition
        return height
        
    }
    
   
    init(presentor: SetSavingsPresentor?, viewData: SetSavingsViewData){
        self.viewData = viewData
        self.presentor = presentor
        
    }
    
    
    var body: some View {


        VStack{
            
 
    
            
            VStack{
                
                GeometryReader {g in
                
                    ZStack{
                          
                        VStack{
                            
                            ZStack{
                            Rectangle()
                                .fill(LinearGradient(gradient:  Gradient(colors: [.yellow, .green]), startPoint: .topTrailing, endPoint: .center))
                                .frame(height: self.getHeight(viewHeight: g.size.height))
                                
                                VStack{
                                    Text("$\(self.viewData.savingsAmount)").font(.title).bold()
                                    Text("savings / month")
                                }
                                
                                
                            }
                            ZStack{
                                Rectangle()
                                .fill(LinearGradient(gradient:  Gradient(colors: [.yellow, .red]), startPoint: .bottomTrailing, endPoint: .center))
                                VStack{
                                    Text("$\(self.viewData.spendingAmount)").font(.title).bold()
                                    Text("Spending / month")
                                }
                            }
                            
                        }
                        
                        HStack{
                            Rectangle().frame(width: 220, height: 20 ).foregroundColor(Color(.white))
                            
                            }.shadow(radius: 30).cornerRadius(5)
                            .offset(y: (CGFloat(self.$viewData.savingsPercentage.wrappedValue) * g.size.height) - (g.size.height/2))
                
                        .gesture(DragGesture()
                        .onChanged({ value in
                            self.sliderPosition = value.location.y
                            self.presentor?.sliderMoved(sliderVal: (Float((value.location.y + g.size.height/2) / g.size.height)))
                            
                        }))
                        
                    }
                    
                    
                    
                    
                }
                
                
                
            }.background(Color(.white)).cornerRadius(30).padding().padding(.horizontal, 20.0).shadow(radius: 50)
            
            Spacer()
            
            Button(action: {
                self.presentor?.userPressedContinue()
            }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Continue").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    Spacer()
                }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
                
                
            }
            
            }.navigationBarTitle(Text("Savings Goal"))
        
}

struct SetSavingsView_Previews: PreviewProvider {
    static var previews: some View {
        SetSavingsView(presentor: nil, viewData: SetSavingsViewData(savingsAmount: "$500", spendingAmount: "$500", savingsPercentage: 0.5))
    }
}

}
