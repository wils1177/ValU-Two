//
//  IncomeLoadedVIew.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/21/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeLoadedVIew: View {
    
    var presentor : EnterIncomePresentor?
    @ObservedObject var viewData : EnterIncomeViewData
    
    init(presentor: EnterIncomePresentor?, viewData: EnterIncomeViewData){
        self.presentor = presentor
        self.viewData = viewData
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Your Income Streams").font(.headline).foregroundColor(.white)
                Spacer()
            }.padding()
            
            ForEach(self.viewData.incomeStreams, id: \.self){ stream in
                HStack{
                    Text(stream.name).font(.body).foregroundColor(.white)
                    Spacer()
                    Text("$" + stream.monthlyAmount + " per month").font(.body).foregroundColor(.white)
                    
                
                }.padding()
            }
            
            
            
            
        }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(10).shadow(radius: 10).padding()
    }
}

struct IncomeLoadedVIew_Previews: PreviewProvider {
    static var previews: some View {
        IncomeLoadedVIew(presentor: nil, viewData: EnterIncomeViewData(timeFrameIndex: 0, incomeAmountText: ""))
    }
}
