//
//  DoneButtonView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/23/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct DoneButtonView<Model>: View where Model: UserSubmitViewModel {
    
    var viewModel: Model?
    
    init(viewModel: Model?){
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack{
            Spacer()
            VStack{
            Spacer()
            Button(action: {
                self.viewModel?.submit()
            }){
                
                HStack{
                    
                    ZStack{
                        Text("Done").font(.subheadline).foregroundColor(.black).bold().padding()
                        
                        
                        
                    }
                    
                }.background(LinearGradient(gradient:  Gradient(colors: [.white, .white]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 20).padding()
                
                
            }
            }
        }
    }
}


