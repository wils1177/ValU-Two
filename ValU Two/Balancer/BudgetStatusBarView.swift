//
//  BudgetStatusBarView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/1/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetStatusBarViewData: Hashable {
    

    var percentage : Double
    var color : Color
    var name : String
    var icon : String
    var action : ((BudgetSection) -> ())?
    var section : BudgetSection?
    var id = UUID()
    
    static func == (lhs: BudgetStatusBarViewData, rhs: BudgetStatusBarViewData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct BudgetStatusBarView: View {
    
    
    var viewData = [
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil"),
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil"),
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil"),
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil"),
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil")
        
    ]
    
    init(viewData: [BudgetStatusBarViewData]){
        self.viewData = viewData
        print("BudgetStatusBarView INIT")
    }
    
    var maxHeight = CGFloat(12)
    
    
   
    
    func getWidthOfBar(totalSize: CGFloat, barCount: Int, percentage: Double) -> CGFloat{
        //return (totalSize * CGFloat(percentage)) - CGFloat((4 * (barCount)) / barCount)
        return totalSize * CGFloat(percentage)
    }
    
    var legendV2 : some View {
        
        ScrollView(.horizontal){
            HStack(alignment: .bottom, spacing: 0){
                ForEach(self.viewData, id: \.self) {entry in
                    
                    if entry.action != nil {
                        
                        Button(action: {
                            // What to perform
                            entry.action!(entry.section!)
                        }) {
                            // How the button looks like
                            LegendEntry(icon: entry.icon, name: entry.name, percentage: entry.percentage, color: entry.color)
                        }.buttonStyle(PlainButtonStyle())
                        
                    }
                    else{
                        LegendEntry(icon: entry.icon, name: entry.name, percentage: entry.percentage, color: entry.color)
                    }
                    
                    

                }
            }.padding(.leading)
        }
    }
    

    
    var backgroundRectangle : some View{
        HStack{
            Rectangle().foregroundColor(Color(.clear))
        }.frame(maxHeight: self.maxHeight).clipShape(Capsule())
    }
    
    var foreGroundBars : some View{
        
            GeometryReader{ g in
                HStack(spacing: 0) {
                    ForEach(self.viewData, id: \.self) {data in
                        if g.size.height < g.size.width{
                            RoundedRectangle(cornerRadius: 0).frame(width: self.getWidthOfBar(totalSize: g.size.width, barCount: self.viewData.count, percentage: data.percentage)).foregroundColor(data.color).opacity(g.size.height < g.size.width ? 1 : 0)
                        }
                        
                  }
                    Spacer()
                }
                
            }.frame(height: self.maxHeight).clipShape(RoundedRectangle(cornerRadius: 7))
        
    }
    
    var body: some View {
        
        VStack(spacing: 3){
            ZStack(alignment: .leading){
                backgroundRectangle
                foreGroundBars
            }.padding(.horizontal)
            legendV2.padding(.top, 15)
        }
        
        
        
        
    }
}

struct LegendEntry : View{
    
    var icon: String
    var name: String
    var percentage: Double
    var color: Color
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Image(systemName: self.icon).foregroundColor(self.color).font(.system(size: 23, design: .rounded)).padding(.trailing, 20)
            }
            
            //BudgetSectionIconLarge(color: entry.color, icon: entry.icon, size: CGFloat(44))
            Text(self.name).font(.system(size: 12, design: .rounded)).bold().lineLimit(1).padding(.trailing, 11).padding(.top, 1)
            Text( String(Int(self.percentage * 100)) + "%").font(.system(size: 18, design: .rounded)).bold().foregroundColor(self.color).padding(.trailing, 15)
        }.padding(.trailing,5).padding(.bottom, 15)
        
    }
}

