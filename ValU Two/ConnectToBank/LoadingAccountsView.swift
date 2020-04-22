//
//  LoadingAccountsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI



struct LoadingAccountsView: View {
    
    @State var spin = false
    var presentor : LoadingAccountsPresentor?
    @ObservedObject var viewData : LoadingAccountsViewData
    
    private func isDoneLoading(for state: LoadingAccountsViewState) -> Bool {
        switch state {
        case .Loading: return false
        case .Success: return true
        case .Failure: return true
        }
    }
    
    private func isSuccessfull(for state: LoadingAccountsViewState) -> Bool {
        print("rejigging view")
        switch state {
        case .Loading: return false
        case .Success: return true
        case .Failure: return false
        }
    }
    
    
    init(presentor: LoadingAccountsPresentor?, viewData: LoadingAccountsViewData){
        self.presentor = presentor
        self.viewData = viewData
    }
    
    @ViewBuilder
    var body: some View {
        
        if isDoneLoading(for: $viewData.viewState.wrappedValue){
            if isSuccessfull(for: $viewData.viewState.wrappedValue){
                //WelcomeView()
                AccountsLoadedView(presentor: self.presentor).transition(.slide)
            }
            else{
                CouldNotLoadAccountsView(presentor: self.presentor)
            }
        }
        else{
            AccountsAreLoadingView(presentor: self.presentor)
        }
        
        
    }
}


struct LoadingAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAccountsView(presentor: nil, viewData: LoadingAccountsViewData())
    }
}

