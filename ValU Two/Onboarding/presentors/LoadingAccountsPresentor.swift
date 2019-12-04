//
//  LoadingAccountsPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/28/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

enum LoadingAccountsViewState{
    case Loading
    case Success
    case Failure
}

class LoadingAccountsViewData : ObservableObject{
    @Published var viewState = LoadingAccountsViewState.Loading
}

class LoadingAccountsPresentor : Presentor {
    
    var view : LoadingAccountsView?
    var coordinator : OnboardingFlowCoordinator?
    var attempts = 0
    let plaid  = PlaidConnection()
    var viewData = LoadingAccountsViewData()
    

    
    func configure() -> UIViewController {
        let view = LoadingAccountsView(presentor: self, viewData: self.viewData)
        let vc = UIHostingController(rootView: view)
        return vc
    }
    
    func viewWillLoad(){
        self.viewData.viewState = LoadingAccountsViewState.Loading
        pullInAccountData()
    }
    
    func pullInAccountData(){
        
        let dispatchA = DispatchGroup()

        
        dispatchA.enter()
        
        print("Exchanging public token...")
        try? plaid.exchangePublicForAccessToken(dispatch: dispatchA, completion: self.tokenExchangeFinished(result:))
        
        
        dispatchA.notify(queue: .main){
            
            self.startTransactionsPull()
    
        }
        
        
    }
    
    func startTransactionsPull(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0){
            print("getting transactions...")
            self.attempts = self.attempts + 1
            try? self.plaid.getTransactions(completion: self.transactionsPullFinished(result:))
        }
    }
    
    func tokenExchangeFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self.viewData.viewState = LoadingAccountsViewState.Failure
                print(error)
            case .success(let dataResult):
                PlaidProccessor().saveAccessToken(response: dataResult)

            }
        }
        
    }
    
    func transactionsPullFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                
                if case PlaidConnectionError.BadRequest = error{
                    //Ping up until 15 times for transaction data to be ready
                    if self.attempts < 15{
                        self.startTransactionsPull()
                    }
                    else{
                        self.viewData.viewState = LoadingAccountsViewState.Failure
                        print(error)
                    }
                }
                else{
                    self.viewData.viewState = LoadingAccountsViewState.Failure
                    print(error)
                }
            case .success(let dataResult):
                PlaidProccessor().aggregate(response: dataResult)
                self.viewData.viewState = LoadingAccountsViewState.Success
            
            }
        }
        
    }
    
    func userPressedContinue(){
        
        self.coordinator?.plaidIsConnected()
        
    }
    
    
}
