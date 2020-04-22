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
                    Text(self.viewData.title).font(.system(size: 17)).foregroundColor(.white).bold().padding(.leading).padding(.top).padding(.bottom, 7)
                    Spacer()
                }
                HStack{
                    Text(self.viewData.description).font(.body).foregroundColor(.white).padding(.leading).padding(.bottom)
                    Spacer()
                }
                

            }
            
            
            
        }.background(self.viewData.backgroundColor).cornerRadius(20).shadow(radius: 20).padding(.leading).padding(.trailing).padding(.bottom, 5))
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
                }
            }
        }
    }
}


