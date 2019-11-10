//
//  SwiftUITestView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SwiftUITestView: View {
    
    let viewData : BudgetCardViewData
    
    init(viewData : BudgetCardViewData){
        self.viewData = viewData
    }
    
    var body: some View {
        
        VStack{
        VStack(alignment: .leading) {
            HStack{
                Text("Budget").font(.title).fontWeight(.bold)
                Spacer()
            }

            HStack{
                Text("Income").font(.subheadline).fontWeight(.bold)
                    Spacer()
                Text(self.viewData.income).font(.subheadline).fontWeight(.bold)
                
            }
            HStack{
                Text("Spent").font(.subheadline).fontWeight(.bold)
                    Spacer()
                Text(self.viewData.spent).font(.subheadline).fontWeight(.bold)
                
            }
            }.padding().background(Color(.yellow)).cornerRadius(20).padding().shadow(radius: 20)
        
        
        }
        
        
    }
}

//struct SwiftUITestView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUITestView()
//    }
//}



