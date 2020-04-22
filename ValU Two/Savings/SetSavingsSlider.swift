//
//  SetSavingsSlider.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SetSavingsSlider: View {
    
    @ObservedObject var viewData : SetSavingsViewData
    var presentor : SetSavingsPresentor?
    
    func getHeight(viewHeight : CGFloat) -> CGFloat{
        
        let height = (viewHeight / 2) + (CGFloat(self.$viewData.savingsPercentage.wrappedValue) * viewHeight) - (viewHeight/2)
        return height
        
    }
    
    
    var body: some View {
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
                                Text("Savings / Month").bold()
                            }
                            
                            
                        }
                        ZStack{
                            Rectangle()
                            .fill(LinearGradient(gradient:  Gradient(colors: [.yellow, .red]), startPoint: .bottomTrailing, endPoint: .center))
                            .transition(.slide)
                            VStack{
                                Text("$\(self.viewData.spendingAmount)").font(.title).bold()
                                Text("Spending / Month").bold()
                            }
                        }
                        
                    }
                    
                    HStack{
                        Rectangle().frame(width: 220, height: 20 ).foregroundColor(Color(.white))
                        
                        }.shadow(radius: 30).cornerRadius(5)
                        .offset(y: (CGFloat(self.$viewData.savingsPercentage.wrappedValue) * g.size.height) - (g.size.height/2))
            
                    .gesture(DragGesture()
                    .onChanged({ value in
                        self.presentor?.sliderMoved(sliderVal: (Float((value.location.y + g.size.height/2) / g.size.height)))
                        print((Float((value.location.y + g.size.height/2) / g.size.height)))
                        
                    }))
                    
                }
                
                
                
                
            }
            
            
            
        }.background(Color(.white)).cornerRadius(30).padding().padding(.horizontal, 20.0).shadow(radius: 50)
    }
}


