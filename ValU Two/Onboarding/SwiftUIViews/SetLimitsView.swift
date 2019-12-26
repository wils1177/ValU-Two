//
//  SetLimitsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/5/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SetLimitsView: View {
    
    @ObservedObject var viewData : SetLimitsViewData
    var presentor : SetSpendingPresentor?
    
    init(presentor: SetSpendingPresentor?, viewData: SetLimitsViewData){
        self.presentor = presentor
        self.viewData = viewData
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        
            VStack{
                
                ScrollView(){
                    SpendingLimitSummaryView(leftToSpend: self.viewData.leftToSpend).padding()
                    
                    ForEach(self.viewData.categoryPercentages, id: \.self){ category in
                        LimitSliderView(presentor: self.presentor, viewCategory: category).padding(.bottom).padding(.horizontal)
                    }
                
                    
                }.navigationBarTitle(Text("Balance Budget"))
                
            }
        
        
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}

/*
struct SetLimitsView_Previews: PreviewProvider {
    static var previews: some View {
        SetLimitsView()
    }
}
*/
