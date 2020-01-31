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
    @State var showingDetail = false
    
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
                
                
            }).navigationBarTitle("ValU Two").navigationBarItems(trailing:
                
                Button(action: {
                    print("clicked the category button")
                    self.showingDetail.toggle()
                }){
                ZStack{
                    
                    Image(systemName: "person.crop.circle").imageScale(.large)
                }
                }.buttonStyle(BorderlessButtonStyle()).sheet(isPresented: $showingDetail) {
                    SettingsView()
                }
                
                
                
            )
            
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
