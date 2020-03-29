//
//  EditOverView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditOverView: View {
    
    var viewModel : BudgetEditor
    
    var body: some View {
        VStack{
            
            HStack{
                Text(self.viewModel.viewData!.description).padding(.horizontal)
                Spacer()
            }.padding(.top)
            
            VStack{
                ForEach(self.viewModel.viewData!.steps, id: \.self) { step in
                    OnboardingStepRow(viewData: step)
                }
            }.padding(.top)
            
            
            Spacer()
            
            Button(action: {
                //Button Action
                self.viewModel.dismiss()
                }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Finish").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    Spacer()
                }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
                
                
            }
            
            
        }.navigationBarTitle(self.viewModel.viewData!.navigationTitle).navigationBarItems(trailing:
            
            Button(action: {
                self.viewModel.dismiss()
            }){
            ZStack{
                
                Text("Dismiss")
            }
            }
            
            
            
        )
        
    }
}


