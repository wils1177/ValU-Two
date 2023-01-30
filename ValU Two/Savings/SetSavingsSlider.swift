//
//  SetSavingsSlider.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SetSavingsSlider: View {
    
    var presentor : SetSavingsPresentor?
    
    @Binding var savingPercentage : Double
    
    var reccommendedSavingsPercentage = 0.2
    
    var scalingFactor : Double
    
    func sliderChange(heightDelta: CGFloat, total: CGFloat){
        let ratio = heightDelta / total
        if !(ratio <= 0 || ratio >= 1.0){
            self.savingPercentage = (1 - (heightDelta / total))
        }
        
        
    }

    var mainRectangles : some View{
        GeometryReader{ g in
            let height = g.size.height
            //let width = g.size.width
            
            VStack(spacing: 0){
                
                Rectangle().foregroundColor(Color(.systemRed)).frame( height: height * ( 1.0 - savingPercentage))
                Rectangle().foregroundColor(Color(.systemGreen)).frame( height: height *  savingPercentage)
                
            }
            
            
        }
    }
    
    var sliderBar : some View{
        GeometryReader{ g in
            let height = g.size.height
            //let width = g.size.width
            
            Capsule().frame(height: 30, alignment: .center).padding(.horizontal, 30).shadow(radius: 12)

                .offset(y: (height * ( 1.0 - savingPercentage)) - 15)
            
                .gesture(DragGesture()
                .onChanged({ value in
                    sliderChange(heightDelta: value.location.y, total: height)
                    
                }))
            
        }
    }
    
    var reccomendLine : some View{
        GeometryReader{ g in
            let height = g.size.height
            let width = g.size.width
            
            let divisions = 5
            
            Path { path in
                
                for index in 1..<(divisions){
                    
                    path.move(to: CGPoint(x: 0, y: height * CGFloat(Double(index) / Double(divisions))))
                    
                    path.addLine(to: CGPoint(
                      x: width,
                      y: height * CGFloat(Double(index) / Double(divisions))))
                    
                }
  
            }
            .stroke(Color(.white), style: StrokeStyle(lineWidth: 2, lineJoin: .round, dash: [5]))
            
            
            
            
        }
    }
    
    func getLabel(divisions: Int, index: Int) -> String{
        let ratio = scalingFactor * (1.0 - (Double(index) / Double(divisions)))
        var fullNum = ratio * 100
        fullNum.round()
        let integer = Int(fullNum)
        return String(integer) + "%"
    }
    
    var reccomendLabel: some View{
        GeometryReader{ g in
            let height = g.size.height
            let width = g.size.width
            
            let divisions = (1...4)
            
            ForEach(divisions, id: \.self) { value in
                ZStack{
                    Capsule().frame(width: 65, height: 20).foregroundColor(Color(.white)).shadow(radius: 5)
                    Text(getLabel(divisions: divisions.count + 1, index: value)).foregroundColor(Color(.systemOrange)).font(.system(size: 13, weight: .semibold, design: .rounded))
                }.offset(x: width - 70, y: (height * CGFloat(Double(value) / Double(divisions.count + 1))) - 10)
                
            }
            
            
            ZStack{
                Capsule().frame(width: 115, height: 20).foregroundColor(Color(.white)).shadow(radius: 5)
                Text("Reccomended!").foregroundColor(Color(.systemOrange)).font(.system(size: 13, weight: .semibold, design: .rounded))
            }.offset(x: 7, y: (height * 0.6) - 10)
            
            
            
        }
    }
    
    var body: some View {
        
        ZStack{
            mainRectangles
            sliderBar
            reccomendLine
            reccomendLabel
        }.cornerRadius(45).shadow(radius: 10).padding(.horizontal, 40).padding(.vertical)
        
    }
}

struct HorizontalSetSavingsSlider: View {
    
    var presentor : SetSavingsPresentor?
    
    @Binding var savingPercentage : Double
    
    var reccommendedSavingsPercentage = 0.2
    
    var scalingFactor : Double
    
    func sliderChange(widthDelta: CGFloat, total: CGFloat){
        let ratio = widthDelta / total
        if !(ratio <= 0 || ratio >= 1.0){
            self.savingPercentage = ((widthDelta / total))
        }
        
        
    }
    
    var mainRectangles : some View{
        GeometryReader{ g in
            //let height = g.size.height
            let width = g.size.width
            
            HStack(spacing: 0){
                
                Rectangle().foregroundColor(Color(.systemGreen)).frame( width: width *  savingPercentage)
                Rectangle().foregroundColor(Color(.systemRed)).frame( width: width * ( 1.0 - savingPercentage))
                
                
            }
            
            
        }
    }
    
    var sliderBar : some View{
        GeometryReader{ g in
            //let height = g.size.height
            let width = g.size.width
            
            Capsule().frame(width: 10, alignment: .center).shadow(radius: 12)

                .offset(x: (width * (savingPercentage)) - 5)
            
                .gesture(DragGesture()
                .onChanged({ value in
                    sliderChange(widthDelta: value.location.x, total: width)
                    
                }))
            
        }
    }
    
    var body: some View{
        
        ZStack{
            
            mainRectangles
            sliderBar
        }.cornerRadius(45).shadow(radius: 10)
        
    }
    
}

struct LinesSetSavingsSlider: View {
    
    
    
    @Binding var savingPercentage : Double
    
    var lines: some View{
        ScrollView(.horizontal){
            
        HStack(){
            
                ForEach(0..<10) { _ in
                    Rectangle().frame(width: 4, height: 50).foregroundColor(Color(.lightGray))
                    
                    ForEach(0..<10) { _ in
                        Rectangle().frame(width: 3, height: 24).foregroundColor(Color(.lightGray))
                    }
                    
                }
            Rectangle().frame(width: 3, height: 50).foregroundColor(Color(.lightGray))
            }
        }
    }
    
    var body: some View{
        
        ZStack{
            lines
            ZStack{
                Text("75%").font(.system(size: 18, weight: .bold, design: .rounded)).lineLimit(3).multilineTextAlignment(.center).foregroundColor(Color(.systemGreen)).offset(y: -60)
                Capsule().frame(width: 10, height: 70).foregroundColor(Color(.systemGreen))
            }
            
        }
        
    }
}


