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
    
    @Environment(\.colorScheme) var colorScheme
    
    private func getBody() -> some View {
        return AnyView(HStack{
            
            ZStack(alignment: .center){
                Circle().frame(width: 52, height: 52, alignment: .center).foregroundColor(colorScheme == .dark ? Color(.systemBackground) : Color(.systemGroupedBackground))
                Image(systemName: self.iconName).font(.system(size: 27, weight: .semibold)).foregroundColor(self.iconColor)
            }.padding(.leading)
            
            
            VStack(spacing: 3){
                
                HStack{
                    Text(self.title).font(.system(size: 21, design: .rounded)).foregroundColor(self.subTectColor).bold().padding(.leading).padding(.top)
                    Spacer()
                }
                HStack{
                    Text(self.description).font(.system(size: 15, design: .rounded)).foregroundColor(self.subTectColor).padding(.leading).padding(.bottom)
                    Spacer()
                }
                

            }
            
            
            
        }.padding(.vertical, 5).background(self.backgroundColor).cornerRadius(24))
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




