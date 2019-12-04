//
//  SwiftUIBudgetView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/13/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SwiftUIBudgetView: View {
    var body: some View {
            
        VStack(){
            
            VStack{
            
            HStack{
                Text("November Budget").font(.title).fontWeight(.bold)
                Spacer()
            }

            HStack{
                
                //Image(systemName: "gamecontroller")
                ZStack(alignment: .leading){
                
                    Capsule().frame(width: 320, height: 30).foregroundColor(.gray).cornerRadius(15)
                    
                    
                    Capsule().frame(width: 70, height: 30).foregroundColor(.clear)
                        .background(LinearGradient(gradient:  Gradient(colors: [.yellow, .green]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(15)

                    
                }
            }
            
            
            HStack{
                
                //Image(systemName: "gamecontroller")
                ZStack(alignment: .leading){
                
                    Capsule().frame(width: 320, height: 30).foregroundColor(.gray).cornerRadius(15)
                    
                    
                    Capsule().frame(width: 170, height: 30).foregroundColor(.clear)
                        .background(LinearGradient(gradient:  Gradient(colors: [.yellow, .green]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(15)

                    
                }
            }
            
            HStack{
                
               // Image(systemName: "gamecontroller")
                ZStack(alignment: .leading){
                
                    Capsule().frame(width: 320, height: 30).foregroundColor(.gray).cornerRadius(15)
                    
                    
                    Capsule().frame(width: 220, height: 30).foregroundColor(.clear)
                        .background(LinearGradient(gradient:  Gradient(colors: [.yellow, .green]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(15)

                    
                }
            }
                
            HStack{
                
               // Image(systemName: "gamecontroller")
                ZStack(alignment: .leading){
                
                    Capsule().frame(width: 320, height: 30).foregroundColor(.gray).cornerRadius(15)
                    
                    
                    Capsule().frame(width: 220, height: 30).foregroundColor(.clear)
                        .background(LinearGradient(gradient:  Gradient(colors: [.yellow, .green]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(15)

                    
                }
            }
                
            HStack{
                
               // Image(systemName: "gamecontroller")
                ZStack(alignment: .leading){
                
                    Capsule().frame(width: 320, height: 30).foregroundColor(.gray).cornerRadius(15)
                    
                    
                    Capsule().frame(width: 220, height: 30).foregroundColor(.clear)
                        .background(LinearGradient(gradient:  Gradient(colors: [.yellow, .green]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(15)

                    
                }
            }
            
            
            
            }.padding()
            
          
            

            }.background(Color(.white)).cornerRadius(10).shadow(radius: 10).padding()
        
        
    }
}

struct SwiftUIBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIBudgetView()
    }
}
