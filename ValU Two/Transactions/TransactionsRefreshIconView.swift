//
//  TransactionsRefreshIconView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/14/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionsRefreshIconView: View {
    
    var viewModel : OnDemandRefreshViewModel
    @ObservedObject var viewData : LoadingAccountsViewData
    
    
    
    init(){
        let viewModel = OnDemandRefreshViewModel()
        self.viewModel = viewModel
        self.viewData = viewModel.viewData
    }
    
    var body: some View {
        
        if viewData.viewState != LoadingAccountsViewState.Loading{
            Button(action: {
                // What to perform
                self.viewModel.startLoadingAccounts()
            }) {
                // How the button looks like
                CircleButtonIcon(icon: "arrow.2.circlepath", color: AppTheme().themeColorPrimary)
                   
                }
            }
        
        else{
    
    
            SpinningCircleView()
        
        
        }
    }
}

struct SpinningCircleView : View{
    @State var animate = false
    
    var body: some View{
        CircleButtonIcon(icon: "arrow.2.circlepath", color: AppTheme().themeColorPrimary)
            .rotationEffect(.degrees(animate ? 360: 0))
            .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
            .onAppear(){
                self.animate.toggle()
            }
    }
}


