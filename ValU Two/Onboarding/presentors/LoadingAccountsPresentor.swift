//
//  LoadingAccountsPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/28/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

class LoadingAccountsPresentor : Presentor {
    
    var viewController : LoadingAccountsViewController?
    var coordinator : OnboardingFlowCoordinator?
    var attempts = 0
    let plaid  = PlaidConnection()
    

    
    func configure() -> UIViewController {
        let vc = LoadingAccountsViewController()
        self.viewController = vc
        self.viewController!.presentor = self
        return self.viewController!
    }
    
    func viewWillLoad(){
        viewController?.enterLoadingState()
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
                self.viewController?.enterErrorState()
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
                        self.viewController?.enterErrorState()
                        print(error)
                    }
                }
                else{
                    self.viewController?.enterErrorState()
                    print(error)
                }
            case .success(let dataResult):
                PlaidProccessor().aggregate(response: dataResult)
                self.viewController?.enterSuccessState()
            
            }
        }
        
    }
    
    func userPressedContinue(){
        
        self.coordinator?.onboardingComplete()
        
    }
    
    
}
