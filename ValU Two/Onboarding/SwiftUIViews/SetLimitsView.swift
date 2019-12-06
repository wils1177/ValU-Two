//
//  SetLimitsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/5/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SetLimitsView: View {
    var body: some View {
        VStack{
            
            ScrollView(){
                SpendingLimitSummaryView().padding()
                LimitSliderView().padding(.bottom)
                LimitSliderView().padding(.bottom)
                LimitSliderView().padding(.bottom)
                LimitSliderView().padding(.bottom)
                LimitSliderView().padding(.bottom)
                LimitSliderView().padding(.bottom)
                LimitSliderView().padding(.bottom)
                LimitSliderView().padding(.bottom)
                
            }
            
        }.navigationBarTitle(Text("Balance Budget"))
        
    }
}

struct SetLimitsView_Previews: PreviewProvider {
    static var previews: some View {
        SetLimitsView()
    }
}
