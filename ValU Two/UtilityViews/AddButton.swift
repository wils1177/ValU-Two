//
//  AddButton.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

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

