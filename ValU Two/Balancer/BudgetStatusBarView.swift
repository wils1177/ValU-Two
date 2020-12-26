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
    var id = UUID()
}

struct BudgetStatusBarView: View {
    
    
    var viewData = [
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil"),
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil"),
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil"),
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil"),
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime", icon: "pencil")
        
    ]
    
    var maxHeight = CGFloat(20)
    
    
    func getLegendArray() -> [[BudgetStatusBarViewData]]{
        return self.viewData.chunked(into: 3)
    }
    
    
    var legend : some View{
        VStack{
            ForEach(self.getLegendArray(), id: \.self) {row in
                HStack{
                    ForEach(row, id: \.self) {entry in
                        HStack{
                            Text(entry.name).font(.system(size: 15)).lineLimit(1).foregroundColor(Color(.white))
                        }.padding(.horizontal, 7).padding(.vertical, 3).background(entry.color).cornerRadius(5)

                    }
                    Spacer()
                }
                
            }
               
        }.padding(.top, 5)
                
    }
    
    var legendV2 : some View {
        
        ScrollView(.horizontal){
            HStack(spacing: 0){
                ForEach(self.getLegendArray(), id: \.self) {row in
                        ForEach(row, id: \.self) {entry in
                            
                            VStack(alignment: .leading){
                                BudgetSectionIconLarge(color: entry.color, icon: entry.icon, size: CGFloat(44))
                                Text(entry.name).font(.caption).foregroundColor(Color(.lightGray)).bold().lineLimit(1)
                            }.frame(width: 85)

                        }
                    
                    
                }
            }.padding(.top, 10)
        }
    }
    

    
    var backgroundRectangle : some View{
        HStack{
            Rectangle().foregroundColor(Color(.systemGroupedBackground))
        }.frame(maxHeight: self.maxHeight).clipShape(Capsule())
    }
    
    var foreGroundBars : some View{
        GeometryReader{ g in
            HStack(spacing: 2) {
                ForEach(self.viewData, id: \.self) {data in
                    Rectangle().frame(width: g.size.width * CGFloat(data.percentage)).foregroundColor(data.color)
              }
                Spacer()
            }
            
        }.frame(height: self.maxHeight).clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    var body: some View {
        VStack{
            ZStack{
                backgroundRectangle
                foreGroundBars
            }.padding(.bottom, 5)
            legend
        }.padding(.horizontal)
        
        
        
        
    }
}

struct BudgetStatusBarView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetStatusBarView()
    }
}
