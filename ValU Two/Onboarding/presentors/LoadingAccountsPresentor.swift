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
    var coordinator : plaidIsConnectedDelegate?
    let plaid  = PlaidConnection()
    let plaidProccesor : PlaidProccessor
    var viewData = LoadingAccountsViewData()
    let budget : Budget
    var itemId : String?
    
    init(budget: Budget){
        self.budget = budget
        self.plaidProccesor = PlaidProccessor(budget: self.budget)
    }
    

    
    func configure() -> UIViewController {
        let view = LoadingAccountsView(presentor: self, viewData: self.viewData)
        let vc = UIHostingController(rootView: view)
        return vc
    }
    
    func viewWillLoad(){
        self.viewData.viewState = LoadingAccountsViewState.Loading
        NotificationCenter.default.addObserver(self, selector: #selector(startTransactionsPull(_:)), name: .initialUpdate, object: nil)
        self.pullInAccountData()

    }
    
    func pullInAccountData(){
        
        //let dispatchA = DispatchGroup()

        
        //dispatchA.enter()
        
        print("Exchanging public token...")
        try? plaid.exchangePublicForAccessToken(completion: self.tokenExchangeFinished(result:))
        
        
    }
    
    @objc func startTransactionsPull(_ notification:Notification){
        
        self.transactionPull()
        
    }
    
    
    func transactionPull(){
        
        let calendar = Calendar.current
        let currentDate = Date()
        let startDate = calendar.date(byAdding: .month, value: -1, to: currentDate)
        let endDate = currentDate
        
        //Todo: Handle this failing
        try? self.plaid.getTransactions(itemId: self.itemId!, startDate: startDate!, endDate: endDate, completion: self.transactionsPullFinished(result:))
        
    }
    
    
    func tokenExchangeFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self.viewData.viewState = LoadingAccountsViewState.Failure
                print(error)
            case .success(let dataResult):
                self.itemId = self.plaidProccesor.saveAccessToken(response: dataResult)

            }
        }
        
    }
    
    func transactionsPullFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self.viewData.viewState = LoadingAccountsViewState.Failure
                print(error)
            case .success(let dataResult):
                self.plaidProccesor.aggregate(response: dataResult)
                TransactionProccessor(budget: self.budget).updateInitialThiryDaysSpent()
                self.viewData.viewState = LoadingAccountsViewState.Success
                print("hey")
                print("ho")
            }
        }
        
    }
    

    
    func userPressedContinue(){
        
        print("plaid is connected")
        self.coordinator?.plaidIsConnected()
        
    }
    
    
}
