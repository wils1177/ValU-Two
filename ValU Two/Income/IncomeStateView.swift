//
//  IncomeStateView.swift
//  
//
//  Created by Clayton Wilson on 12/20/19.
//

import SwiftUI

struct IncomeStateView: View {
    
    var presentor : EnterIncomePresentor?
    @ObservedObject var viewData : EnterIncomeViewData
    
    init(presentor: EnterIncomePresentor?, viewData: EnterIncomeViewData){
        self.presentor = presentor
        self.viewData = viewData
    }
    
    private func isLoadingIncome(for state: LoadingIncomeViewState) -> Bool {
        switch state {
        case .Loading: return true
        default: return false
        }
    }
    
    private func isLoadingSuccess(for state: LoadingIncomeViewState) -> Bool {
        switch state {
        case .Success: return true
        default: return false
        }
    }
    
    private func isInitialState(for state: LoadingIncomeViewState) -> Bool {
        switch state {
        case .Initial: return true
        default: return false
        }
    }
    
    private func isLoadingFailed(for state: LoadingIncomeViewState) -> Bool {
        switch state {
        case .Failure: return true
        default: return false
        }
    }
    
    @ViewBuilder
    var body: some View {
        
        if self.isLoadingIncome(for: self.$viewData.viewState.wrappedValue){
            LoadingIncomeView()
            
        }
            
        else if self.isLoadingSuccess(for: self.$viewData.viewState.wrappedValue){
            //IncomeLoadedVIew(presentor: self.presentor, viewData: self.viewData).transition(.slide)
            Text("hi")
        }
         
         
        else if self.isLoadingFailed(for: self.$viewData.viewState.wrappedValue){
            LoadingIncomeView()
            
        }
        else if self.isInitialState(for: self.$viewData.viewState.wrappedValue){
            InitialIncomeView(presentor: self.presentor)
        }
        
    }
}

struct IncomeStateView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeStateView(presentor: nil, viewData: EnterIncomeViewData(timeFrameIndex: 0, incomeAmountText: ""))
    }
}
