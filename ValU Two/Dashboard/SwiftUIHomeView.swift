//
//  SwiftUIHomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ScrollView(.vertical, content: {
            VStack(alignment: .leading){
                HStack{
                    Text("Hello Clay").font(.largeTitle).fontWeight(.heavy).padding()
                    Spacer()
                    
                    
                    Button(action: {
                        
                    }){
                        ZStack{
                            Image(uiImage: UIImage(systemName: "gear")!).padding().background(Color(.white)).cornerRadius(50).shadow(radius: 3)
                        }.padding(.trailing, 30)
                        
                    }
                    
                    
                    
                }
                BudgetCardView(viewModel: self.viewModel.viewData!.budgetCardViewModel)
                SpendingCardView(viewModel: self.viewModel.viewData!.spendingCardViewModel)
                SwiftUIAccountsView()
                Spacer()
                
                
            }
            
            
        })
        
        
        
        
    }
}
/*
struct SwiftUIHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIHomeView()
    }
}
*/
