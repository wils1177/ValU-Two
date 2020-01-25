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
        
        NavigationView{
            
            ScrollView(.vertical, content: {
                VStack(alignment: .leading){
                    
                    BudgetCardView(viewModel: self.viewModel.viewData!.budgetCardViewModel).padding(.top)
                    SpendingCardView(viewModel: self.viewModel.viewData!.spendingCardViewModel)
                    SwiftUIAccountsView()
                    Spacer()
                    
                    
                }
                
                
            }).navigationBarTitle("ValU Two")
            
        }
        
    }
}
/*
struct SwiftUIHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIHomeView()
    }
}
*/
