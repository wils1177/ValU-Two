//
//  LineView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI


struct LineView: View {
  var dataSet1: [Double]
    var dataSet2: [Double]
    var cutOffValue: Double
    var color1 : Color
    var color2: Color
    var cutOffColor: Color
    
    //This should match the count of larger data set.
    var legendSet: [Date]
    
    //var lineGradient: GradientColor = GradientColor(start: Color.neonPurple, end: Color.neonOceanBlue)
    
    
    func getLegendLabel(index: Int, divisions: Int) -> String{
        
        var trueIndex = 0
        if index != 0 {
            trueIndex = Int((Double(index) / Double(divisions)) * Double(self.legendSet.count - 1))
            
        }
        
        let labelDate = self.legendSet[trueIndex]
        
        
        let monthInt = Calendar.current.component(.month, from: labelDate) // 4
        let monthStr = Calendar.current.monthSymbols[monthInt-1]  // April
        
        let dayInt = Calendar.current.component(.day, from: labelDate) // 4
        let dayStr = String(dayInt)  // April
        
        return monthStr + " " + dayStr
        
    }

  var highestPoint: Double {
      
      
    let max1 = dataSet1.max() ?? 1.0
      let max2 = dataSet2.max() ?? 1.0
      let max = [max1, max2, cutOffValue].max() ?? 1.0
    if max == 0 { return 1.0 }
      return max * 1.1
       
  }
    
    var maxCount : Int{
        
        return self.legendSet.count
        
    }
    
    var spendingLabelView : some View{
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            
            VStack(alignment: .leading){
                
                if (Double(dataSet1.count) / Double(maxCount)) > 0.85{
                    Text(CommonUtils.makeMoneyString(number: Int(dataSet1.last!))).font(.system(size: 13, weight: .bold)).foregroundColor(color1).offset(x: CGFloat((dataSet1.count - 1)) * width / CGFloat(maxCount - 1) - 40,
                                        y: height * (1 - (dataSet1.last! / highestPoint)) - 16)
                }
                else{
                    Text(CommonUtils.makeMoneyString(number: Int(dataSet1.last!))).font(.system(size: 13, weight: .bold)).foregroundColor(color1).offset(x: CGFloat((dataSet1.count - 1)) * width / CGFloat(maxCount - 1) - 23,
                                        y: height * (1 - (dataSet1.last! / highestPoint)) - 16)
                }
                
                
            }
            
        }
    }
    
    var verticalLines: some View{
        GeometryReader { geometry in
          let height = geometry.size.height
          let width = geometry.size.width
            
            let divisions = 4
            
           
            
            Path { path in
                
                for index in 0..<(divisions + 1){
                    
                    let xval = CGFloat(Float(width) * (Float(index) / Float(divisions)))
                    
                    //Line 1
                    path.move(to: CGPoint(x: xval, y: 0))
                    
                    path.addLine(to: CGPoint(
                      x: xval,
                      y: height))
                    
                }
                        
                
            }.stroke(Color(.gray).opacity(0.2), style: StrokeStyle(lineWidth: 1, lineJoin: .round, dash: [5]))
            
            
            
            
            
            
            
        }
    }
    
    var labels: some View{
        GeometryReader{geometry in
            //let height = geometry.size.height
            let width = geometry.size.width
            
            
            let divisions = (0...4)
            
            ForEach(divisions, id: \.self) { value in
                VStack(alignment: .center){
                    if value != divisions.last!{
                        Text(self.getLegendLabel(index: value, divisions: divisions.count - 1)).font(.system(size: 10, weight: .semibold)).foregroundColor(Color(.gray).opacity(0.3))
                    }
                    
                }.offset(x: CGFloat(Float(width) * (Float(value) / Float(divisions.last!))), y: -15)
                
            }
            
   
        }
        
        
    }
    
    var horizontalLines : some View{
        
        GeometryReader { geometry in
          let height = geometry.size.height
          let width = geometry.size.width
            
            Path { path in
                
                path.move(to: CGPoint(x: 0, y: 0))
                
                //Line 1
                path.addLine(to: CGPoint(
                  x: width,
                  y: 0))
                
                //Line 2
                path.move(to: CGPoint(x: 0, y: height * 0.25))
                
                path.addLine(to: CGPoint(
                  x: width,
                  y: height * 0.25))
                
                
                //Line 3
                path.move(to: CGPoint(x: 0, y: height * 0.5))
                
                path.addLine(to: CGPoint(
                  x: width,
                  y: height * 0.5))
                
                
                //Line 4
                path.move(to: CGPoint(x: 0, y: height * 0.75))
                
                path.addLine(to: CGPoint(
                  x: width,
                  y: height * 0.75))
                
                
                //Line 4
                path.move(to: CGPoint(x: 0, y: height))
                
                path.addLine(to: CGPoint(
                  x: width,
                  y: height))
                
                
            }.stroke(Color(.gray).opacity(0.2), style: StrokeStyle(lineWidth: 1, lineJoin: .round))
            
        }
        
    }
    
    
    
    
    

  var lines: some View {
    GeometryReader { geometry in
      let height = geometry.size.height
      let width = geometry.size.width

       
  
        //Path 2
        Path { path in
          path.move(to: CGPoint(x: 0, y: height * self.ratio2(for: 0)))

          for index in 1..<dataSet2.count {
            path.addLine(to: CGPoint(
              x: CGFloat(index) * width / CGFloat(maxCount - 1),
              y: height * self.ratio2(for: index)))
          }
        }
        .stroke(self.color2.opacity(0.6), style: StrokeStyle(lineWidth: 4, lineJoin: .round))
        
        
        
        Path { path in
          path.move(to: CGPoint(x: 0, y: height * self.ratio1(for: 0)))

          for index in 1..<dataSet1.count {
              if index != (dataSet1.count - 1){
                  path.addLine(to: CGPoint(
                    x: CGFloat(index) * width / CGFloat(maxCount - 1),
                    y: height * self.ratio1(for: index)))
              }
              else{
                  path.addArc(center: CGPoint(
                              x: CGFloat(index) * width / CGFloat(maxCount - 1),
                              y: height * self.ratio1(for: index)),
                                        radius: 4, startAngle: .zero,
                                        endAngle: .degrees(360.0), clockwise: false)
                  
                  
              }
            
          }
            
            
            
            
        }
        
        .stroke(self.color1, style: StrokeStyle(lineWidth: 4, lineJoin: .round))
        
        
        
        
        LinearGradient(gradient: Gradient(colors: [self.color1.opacity(0.45), self.color1.opacity(0.005)]), startPoint: .top, endPoint: .bottom)
            .mask(
                Path { path in
                  path.move(to: CGPoint(x: 0, y: height * self.ratio1(for: 0)))

                  for index in 1..<dataSet1.count {
                          path.addLine(to: CGPoint(
                            x: CGFloat(index) * width / CGFloat(maxCount - 1),
                            y: height * self.ratio1(for: index)))
                      
                      
                    
                  }
                    
                    path.addLine(to: CGPoint(x: CGFloat(dataSet1.count-1) * width / CGFloat(maxCount - 1), y: height))
                    
                    path.addLine(to: CGPoint(x: 0.0, y: height))
                    path.closeSubpath()
                    
                    
                    
                }
            )
        
    }
    .padding(.vertical)
  }
    
    var cutOffLine: some View{
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            
            ZStack{
                
                
                
                //CutoffPath
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: height * (1 - (self.cutOffValue / highestPoint))))
                    
                    path.addLine(to: CGPoint(
                      x: CGFloat(maxCount - 1) * width / CGFloat(maxCount - 1),
                      y: height * (1 - (self.cutOffValue / highestPoint))))
                    
                    
                }
                .stroke(self.cutOffColor, style: StrokeStyle(lineWidth: 2, lineJoin: .round, dash: [5]))
                
                //CutOff Label
                //Text("test").foregroundColor(Color(.systemOrange)).offset(x: 0, y: height * (1 - (self.cutOffValue / highestPoint)))
                 
            }
        }
        
        
    }
    
    var body: some View{
        ZStack{
            self.horizontalLines
            self.verticalLines
            self.labels
            self.spendingLabelView
            self.lines
            self.cutOffLine
        }
    }

  private func ratio1(for index: Int) -> Double {
    1 - (dataSet1[index] / highestPoint)
  }
    
    private func ratio2(for index: Int) -> Double {
        1 - (dataSet2[index] / highestPoint)
    }
}

