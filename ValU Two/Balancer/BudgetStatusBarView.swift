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
    var id = UUID()
}

struct BudgetStatusBarView: View {
    
    
    var viewData = [
        BudgetStatusBarViewData(percentage: 0.15, color: .blue, name: "Drugs"),
        BudgetStatusBarViewData(percentage: 0.15, color: .red, name: "Crime"),
        BudgetStatusBarViewData(percentage: 0.15, color: .green, name: "Fun"),
        BudgetStatusBarViewData(percentage: 0.03, color: .purple, name: "1"),
        BudgetStatusBarViewData(percentage: 0.03, color: .purple, name: "1")
        
    ]
    
    var maxHeight = CGFloat(12)
    
    
    func getLegendArray() -> [[BudgetStatusBarViewData]]{
        return self.viewData.chunked(into: 3)
    }
    
    
    var legend : some View{
        VStack{
            ForEach(self.getLegendArray(), id: \.self) {row in
                HStack{
                    ForEach(row, id: \.self) {entry in
                        HStack{
                            Circle().frame(width: 10, height: 10).foregroundColor(entry.color)
                            Text(entry.name).font(.system(size: 12))
                        }.padding(.horizontal, 5)

                    }
                    Spacer()
                }
                
            }
               
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
            
        }.frame(height: self.maxHeight).clipShape(Capsule())
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
