//
//  OnboardingStepRow.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI


struct OnboardingStepViewData: Hashable{
    
    static func == (lhs: OnboardingStepViewData, rhs: OnboardingStepViewData) -> Bool {
        return lhs.hash == rhs.hash
    }
    
    var title : String
    var description : String
    var iconName: String
    var iconColor: Color
    var backgroundColor: Color
    var subTectColor : Color
    var completionHandler: (()->Void)?
    var hash = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(hash)
    }
}




struct OnboardingStepRow: View {
    
    var viewData : OnboardingStepViewData
    
    init(viewData: OnboardingStepViewData){
        self.viewData = viewData
    }
    
    private func getBody() -> some View {
        return AnyView(HStack{
            
            Image(systemName: self.viewData.iconName).resizable()
                .frame(width: 30.0, height: 30.0).foregroundColor(self.viewData.iconColor).padding(.leading)
            
            VStack{
                
                HStack{
                    Text(self.viewData.title).font(.system(size: 17)).foregroundColor(self.viewData.backgroundColor).bold().padding(.leading).padding(.top).padding(.bottom, 5)
                    Spacer()
                }
                HStack{
                    Text(self.viewData.description).font(.subheadline).foregroundColor(self.viewData.subTectColor).padding(.leading).padding(.bottom)
                    Spacer()
                }
                

            }
            
            
            
        }.background(Color(.white)).cornerRadius(20).padding(.bottom, 5))
    }
    
    var body: some View {
        
        VStack{
            if self.viewData.completionHandler == nil {
                self.getBody()
            }
            else{
                Button(action: {
                //Button Action
                    self.viewData.completionHandler!()
                }){
                    self.getBody()
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}


