//
//  SelectCategoriesView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SelectCategoriesView: View {
    
    var viewModel : BudgetCardsPresentor

    init(viewModel: BudgetCardsPresentor){
        self.viewModel = viewModel
    }
    

    
    
    var body: some View {
        
        VStack{
            
            
            VStack{
                
                Spacer()
                
                
                
                
                ZStack{
                    
                    
                    
            ScrollView(.vertical, content: {
                VStack{
                    
                    VStack{
                        Text("Go ahead and pick some budget categories, ya nut!").bold().lineLimit(nil).multilineTextAlignment(.center).foregroundColor(.white).padding()
                        }.padding()
                    
                    CategoryCardListView<BudgetCardsPresentor>(viewModel: self.viewModel)
                    
                }
            })
                    
                    
                    
                    VStack{
                    Spacer()
                    
                        DoneButtonView(viewModel: self.viewModel)
                        
                        
                    }
                    
                    
                
                }
            }
            .background(Color(.black)).cornerRadius(40).shadow(radius: 20).edgesIgnoringSafeArea(.bottom).padding(.top, 20)
            
            
            
            
        }.navigationBarTitle(Text("Budget Categories"))
        
        
        
        
    }
}

