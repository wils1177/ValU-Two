//
//  HistoryGraphView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/31/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoryGraphBarSegment: Hashable{
    var color: Color
    var name: String
    var value: Double
    var icon: String? = "book"
}

struct HistoryGraphBar: Hashable{
    var label: String
    var totalValue : Double?
    var segments : [HistoryGraphBarSegment]
}




struct HistoryGraphView: View {
    
    
    
    var bars : [HistoryGraphBar]
    
    var sideBySide : Bool = false
    
    @State var selectedBar : HistoryGraphBar? = nil
    
    
    var highestSegment : Double {
        var highest = 0.0
        
        for bar in self.bars{
            for segment in bar.segments{
                if segment.value > highest{
                    highest = segment.value
                }
            }
        }
        return highest
    }
    
    var highestBar: Double{
        var highest = 0.0
        
        if !sideBySide{
            for bar in self.bars{
                var barTotal = 0.0
                for segment in bar.segments{
                    barTotal = barTotal + segment.value
                }
                if barTotal > highest{
                    highest = barTotal
                }
            }
        }
        else{
            for bar in self.bars{
                for segment in bar.segments{
                    if segment.value > highest{
                        highest = segment.value
                    }
                }
            }
        }
        
        
        
        if highest < 100 {
            return ((highest / 100).rounded(FloatingPointRoundingRule.up)) * 100
        }
        else{
            return ((highest / 1000).rounded(FloatingPointRoundingRule.up)) * 1000
        }
        
        
        
    }
    
    var averageBar : Double{
        
        if bars.count == 0 {
            return 0
        }
        else{
            var total = 0.0
            var trueCount = 0
            for bar in self.bars{
                if bar.totalValue != 0{
                    trueCount = trueCount + 1
                    total = total + bar.totalValue!
                }
                
            }
            return total / Double(trueCount)
        }
        
    }
    
    func getLineValue(divisions: Int, index: Int) -> String{
        
        let value = (self.highestBar / Double(divisions)) * Double(divisions - index)
        return CommonUtils.makeMoneyString(number: Int(value))
    }
    
    var lineLabels: some View{
        
        GeometryReader{ g in
            let height = g.size.height
            //let width = g.size.width
            
            let divisions = (0...5)
            
            
            //Draw the Labels
            ForEach(divisions, id: \.self) { value in
                VStack(alignment: .center, spacing: 0){
                    //if value != divisions.last!{
                        
                        Text(self.getLineValue(divisions: divisions.last!, index: value)).font(.system(size: 10, weight: .semibold)).foregroundColor(Color(.gray).opacity(0.3))
                    //}
                    
                }.offset(x: 0, y: CGFloat(Float(height) * (Float(value) / Float(divisions.last!))))
                
            }
            
        }
        
    }
    
    func getBottomLineValue(index: Int) -> String{
        
        return bars[index].label
    }
    
    var bottomLabels : some View{
        
        GeometryReader{ g in
            
            //ScrollView(.horizontal){
                
                
                HStack(alignment: .bottom){
                        
                        ForEach(self.bars, id: \.self){ bar in
                            Spacer()
                            VStack(alignment: .center, spacing: 0){
                                Text(bar.label).font(.system(size: 10, weight: .semibold)).foregroundColor(Color(.gray).opacity(0.3))
                            }
                            .frame(width: 45)
                            
                          
                            Spacer()
                        }
                        
                            
                }.offset(y: g.size.height + 10)
                        
                        
                    
                    
                    
                }
            //}
            
        
        
    }
    
    var horizontalLines: some View{
        GeometryReader{ g in
            let height = g.size.height
            let width = g.size.width
            
            let divisions = 5
            
            
          
            
            //Draw the Lines
            Path { path in
                
                for index in 0..<(divisions + 1){
                    
                    let yval = CGFloat(Float(height) * (Float(index) / Float(divisions)))
                    
                    //Line 1
                    path.move(to: CGPoint(x: 40, y: yval))
                    
                    path.addLine(to: CGPoint(
                      x: width,
                      y: yval))
                    
                }
                        
                
            }.stroke(Color(.gray).opacity(0.2), style: StrokeStyle(lineWidth: 1, lineJoin: .round, dash: [5]))
            
            
           
            
            
            
        }
    }
    
    
    var barViews: some View{
        
        GeometryReader{ g in
            
            //ScrollView(.horizontal){
                
                
                HStack(alignment: .bottom){
                        
                        ForEach(self.bars, id: \.self){ bar in
                            Spacer()
                            
                            
                            VStack(alignment: .center, spacing: 0){
                                
                                //Bar
                                    Spacer()
                                
                                if !sideBySide{
                                    Text(CommonUtils.makeMoneyString(number: Int(bar.totalValue ?? 0))).font(.system(size: 10, design: .rounded)).bold().foregroundColor(Color(.lightGray)).offset(y: -3).lineLimit(1)
                                }
                                
                                
                                
                                    if sideBySide{
                                        
                                        
                                        Button(action: {
                                            // What to perform
                                            //self.selectedBar = bar
                                        }) {
                                            // How the button looks like
                                            SideBySideBarView(historyGraphBar: bar, highestSegment: self.highestSegment).frame(width: 45)
                                        }
                                        
                                    }
                                    else{
                                        
                                       
                                            // How the button looks like
                                            HistoryGraphBarView(historyGraphBar: bar, highestBar: self.highestBar).frame(width: 45, height: g.size.height * ratio(val: bar.totalValue!), alignment: .bottom).clipShape(RoundedRectangle(cornerRadius: 7))
                                        
                                        
                                        
                                        
                                    }
                                    
                               
                                
                                //Label
                                //Text(bar.label).font(.system(size: 14, weight: .semibold, design: .rounded)).foregroundColor(Color(.lightGray)).lineLimit(1).padding(.top, 10)
                            }
                            
                            Spacer()
                        }
                        
                        
                    
                    
                    
                }
            //}
            
        }
  
        
    }
    
    func ratio(val: Double) -> Double{
        return val / self.highestBar
    }
    
    var legend : some View{
        VStack{
            if self.bars.first != nil{
                ScrollView(.horizontal){
                    
                    
                    HStack(spacing: 0){
                        
                        NavigationBarTextIconButton(text: "All", icon: "globe", color: Color.gray)
                        
                        ForEach(self.bars.first!.segments.reversed(), id: \.self){ segment in
                            NavigationBarTextIconButton(text: segment.name, icon: segment.icon!, color: segment.color)
                        }.padding(.horizontal, 5)
                    }
                }
            }
        }
    }
    
    var selectedBarText : some View{
        VStack{
            
            if !sideBySide{
                HStack{
                    Text("Spent during " + self.selectedBar!.label).font(.system(size: 17, design: .rounded)).fontWeight(.bold).foregroundColor(Color(.lightGray)).listRowSeparator(.hidden)
                    Spacer()
                }
            }
            else{
                HStack{
                    Text("Net Cash Flow for " + self.selectedBar!.label).font(.system(size: 17, design: .rounded)).fontWeight(.bold).foregroundColor(Color(.lightGray)).listRowSeparator(.hidden)
                    Spacer()
                }
            }
            
            HStack{
                Text(CommonUtils.makeMoneyString(number: Int(self.selectedBar!.totalValue!))).font(.system(size: 31, design: .rounded)).fontWeight(.bold).listRowSeparator(.hidden)
                Spacer()
            }
        }
        
        
    }
    
    var averageText: some View{
        VStack{
            if !self.sideBySide{
                VStack{
                    
                    HStack{
                        Text("Average Spending").font(.system(size: 17, design: .rounded)).fontWeight(.bold).foregroundColor(Color(.lightGray)).listRowSeparator(.hidden)
                        Spacer()
                    }
                    HStack{
                        Text(CommonUtils.makeMoneyString(number: Int(self.averageBar))).font(.system(size: 28, design: .rounded)).fontWeight(.bold).listRowSeparator(.hidden)
                        Spacer()
                    }
                }
            }
            else{
                VStack{
                    
                    HStack{
                        Text("Average Net Cash Flow").font(.system(size: 17, design: .rounded)).fontWeight(.bold).foregroundColor(Color(.lightGray)).listRowSeparator(.hidden)
                        Spacer()
                    }
                    HStack{
                        Text(CommonUtils.makeMoneyString(number: Int(self.averageBar))).font(.system(size: 28, design: .rounded)).fontWeight(.bold).listRowSeparator(.hidden)
                        Spacer()
                    }
                }
            }
        }
        
        
        
    }
    
    var body: some View {
        
        VStack{
            
            /*
            if self.selectedBar != nil{
                
                self.selectedBarText
            }
            else{
                self.averageText
            }
            */
            
            ZStack{
                
                self.horizontalLines
                self.lineLabels.offset(y: -6)
                self.bottomLabels.padding(.leading, 35)
                self.barViews.padding(.leading, 35)
                
            }.frame(height: 200)
            
        }
        
            
        
    }
    
    private func ratio(value: Double) -> Double {
        return value / self.highestBar
    }
    
    
}

struct HistoryGraphBarView : View{
    var historyGraphBar : HistoryGraphBar
    var highestBar : Double
    
    var body: some View {
        
        GeometryReader{g in
            let height = g.size.height
            let width = g.size.width
            
                VStack(alignment: .center, spacing: 0){
                    
                    ForEach(self.historyGraphBar.segments, id: \.self){ segment in
                        //if ratio(value: segment.value) > 0.03{
                        
                            Rectangle().fill(segment.color.opacity(0.9)).frame(width: 45, height: (height * ratio(value: segment.value)))
                        //}
                        
                    }
                    
                }.frame(width: width, height: height, alignment: .bottom)
            
            
            
        }
        
    }
    
    
    
    private func spacingOffset() -> Double{
        ((Double(self.historyGraphBar.segments.count)) * 4.0) / Double(self.historyGraphBar.segments.count)
    }
    
    private func ratio(value: Double) -> Double {
        
        return (value) / self.historyGraphBar.totalValue!
    }
}

struct SideBySideBarView: View{
    var historyGraphBar : HistoryGraphBar
    var highestSegment : Double
    
    var body: some View {
        
        GeometryReader{g in
            let height = g.size.height
            let width = g.size.width
            
            VStack(alignment: .center, spacing: 0.0){
                Spacer()
                HStack(alignment: .bottom){
                    
                    ForEach(self.historyGraphBar.segments, id: \.self){ segment in
                        RoundedRectangle(cornerRadius: 8).fill(segment.color.opacity(0.9)).frame(width: 15, height: (height * ratio(value: segment.value)))
                    }
                }
                
            }
            
            
        }
        
    }
    
    private func spacingOffset() -> Double{
        ((Double(self.historyGraphBar.segments.count)) * 4.0) / Double(self.historyGraphBar.segments.count)
    }
    
    private func ratio(value: Double) -> Double {
        return value / self.highestSegment
    }
}


