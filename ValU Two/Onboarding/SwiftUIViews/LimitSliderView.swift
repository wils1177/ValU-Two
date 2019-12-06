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
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Category Name").font(.headline).bold().padding(.leading)
                Spacer()
                Text("$200").font(.headline).bold().padding(.leading).padding(.trailing)
            }
            HStack{
                ZStack{
                    

                    HStack{
                        Rectangle().frame(height: 30).foregroundColor(Color(.black))
                        
                        }.cornerRadius(10).padding(.horizontal).shadow(radius: 20)
                    
                    HStack{
                        Rectangle().frame(width: $sliderPosition.wrappedValue, height: 30).foregroundColor(Color(.red))
                        Spacer()
                    }.cornerRadius(10).padding(.horizontal)
                    
                    HStack{
                        
                        Rectangle().frame(width: 10, height: 40).foregroundColor(Color(.blue)).offset(x: $sliderPosition.wrappedValue)
                            
                            .gesture(DragGesture()
                        .onChanged({ value in
                            self.sliderPosition = value.location.x
                            
                            
                        }))
                        
                        
                        Spacer()
                    }.shadow(radius: 20).padding(.horizontal)
                    
                }
                
            }
            
            HStack{ Text("0%").font(.headline).bold().padding(.leading)
                Spacer()
                Text("100%").font(.headline).bold().padding(.leading).padding(.trailing)
            }
        }
        
        
    }
}

struct LimitSliderView_Previews: PreviewProvider {
    static var previews: some View {
        LimitSliderView()
    }
}
