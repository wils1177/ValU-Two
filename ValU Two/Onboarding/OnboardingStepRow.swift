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


struct GenericOnboardingStepRow : View{
    
    var title : String
    var description : String
    var iconName: String
    var iconColor: Color
    var backgroundColor: Color
    var subTectColor : Color
    var completionHandler: (()->Void)?
    
    private func getBody() -> some View {
        return AnyView(HStack{
            
            Image(systemName: self.iconName).resizable()
                .frame(width: 30.0, height: 30.0).foregroundColor(self.iconColor).padding(.leading)
            
            VStack{
                
                HStack{
                    Text(self.title).font(.system(size: 17)).foregroundColor(self.backgroundColor).bold().padding(.leading).padding(.top)
                    Spacer()
                }
                HStack{
                    Text(self.description).font(.subheadline).foregroundColor(self.subTectColor).padding(.leading).padding(.bottom)
                    Spacer()
                }
                

            }
            
            
            
        }.background(Color(.white)).cornerRadius(20))
    }
    
    var body: some View {
        
        VStack{
            if self.completionHandler == nil {
                self.getBody()
            }
            else{
                Button(action: {
                //Button Action
                    self.completionHandler!()
                }){
                    self.getBody()
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
    
}




