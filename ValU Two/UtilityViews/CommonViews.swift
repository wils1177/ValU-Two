//
//  AddButton.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct NavigationBarTextButton: View {
    var text : String
    var color : Color = AppTheme().themeColorPrimary
    
    var body : some View {
        ZStack(alignment:.center){
            Text(self.text).font(Font.system(size: 16, weight: .semibold)).foregroundColor(color)
                .padding(.horizontal, 13).padding(.vertical, 5).background(color.opacity(0.15)).cornerRadius(20)
            
    }
    }
    
}

struct NavigationBarTextIconButton: View {
    var text : String
    var icon : String
    
    var body : some View {
        HStack(alignment:.center, spacing: 2){
            Image(systemName: self.icon).font(.system(size: 16, weight: .semibold))
            Text(self.text).font(Font.system(size: 16, weight: .semibold))
            
    }.foregroundColor(AppTheme().themeColorPrimary)
        .padding(.horizontal, 13).padding(.vertical, 5).background(AppTheme().themeColorPrimary.opacity(0.15)).cornerRadius(20)
    }
    
}

struct CircleButtonIcon : View {
    var icon: String
    var color: Color
    
    var circleSize : CGFloat = 32
    var fontSize : CGFloat = 15
    
    var body: some View {
        ZStack(alignment:.center){
            Circle().frame(width: circleSize, height: circleSize, alignment: .center).foregroundColor(color.opacity(0.15))
            Image(systemName: self.icon).font(Font.system(size: fontSize, weight: .bold)).foregroundColor(color)
        }
    }
}



struct ActionButtonLarge: View {
    var text : String
    var enabled = true
    
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        if enabled {
            HStack{
                Spacer()
                ZStack{
                    Text(self.text).font(.headline).foregroundColor(colorScheme == .dark ? Color.black : Color.white).bold().padding()
                }
                Spacer()
            }.background(AppTheme().themeColorPrimary).cornerRadius(20).shadow(radius: 10).padding().padding(.horizontal).padding(.bottom)
        }
        else {
            HStack{
                Spacer()
                ZStack{
                    Text(self.text).font(.headline).foregroundColor(colorScheme == .dark ? Color.white : Color.black).bold().padding()
                }
                Spacer()
            }.background(Color(.lightGray)).cornerRadius(20).shadow(radius: 0).padding().padding(.horizontal).padding(.bottom)
        }
        
    }
}


struct SectionHeader: View {
    
    var title : String
    var image : String
    
    var body : some View{
        HStack(spacing: 5){
            Image(systemName: self.image).foregroundColor(AppTheme().themeColorPrimary).font(.system(size: 20, design: .rounded))
            Text(self.title).font(.system(size: 20, design: .rounded)).fontWeight(.semibold).fontWeight(.medium)
            Spacer()

        }
    }
}


struct AddButton: View {
    
    var viewModel : BudgetBalancerPresentor
    
    var body: some View {
        VStack{
            
            Spacer()
            HStack{
                Text("Add your some categories to your budget!").foregroundColor(Color(.lightGray))
                Spacer()
            }.padding()

                
            VStack{
                HStack{
                    Spacer()
                    
                    Button(action: {
                        print("does nothing")
                    }){
                        Image(systemName: "plus.circle.fill").imageScale(.large)
                        Text("Add Category").fontWeight(.bold)
                    }.buttonStyle(BorderlessButtonStyle())

                    Spacer()
                }.padding()
            }.background(Color(.cyan)).cornerRadius(10)
                    
                
            
            

        
        Spacer()
        
    }
}
}

