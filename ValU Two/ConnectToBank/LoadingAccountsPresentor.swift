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
import FirebaseCrashlytics

enum LoadingAccountsViewState{
    case Loading
    case Success
    case Failure
    case Initial
    case SettingUpLink
}

class LoadingAccountsViewData : ObservableObject{
    @Published var viewState = LoadingAccountsViewState.Loading
}

class LoadingAccountsPresentor : Presentor, PlaidLinkDelegate {
    
    

    var view : LoadingAccountsView?
    var coordinator : PlaidLinkDelegate?
    var aggregationService : PlaidInitialAggService?
    var viewData = LoadingAccountsViewData()
    var itemId : String?
    var itemManager : ItemManagerService
    var plaidLinkPresentor : PlaidLinkViewPresentor?
    
    init(itemManager: ItemManagerService){
        self.viewData.viewState = LoadingAccountsViewState.Initial
        self.itemManager = itemManager
    }

    
    func configure() -> UIViewController {
        let view = LoadingAccountsView(presentor: self, viewData: self.viewData)
        let vc = UIHostingController(rootView: view)
        self.aggregationService = PlaidInitialAggService(completion: self.handleAggregationResult(result:))
        self.plaidLinkPresentor = PlaidLinkViewPresentor(viewControllerToPresentOver: vc)
        self.plaidLinkPresentor?.coordinator = self
        return vc
    }
    
    func launchPlaidLink() {
        self.viewData.viewState = LoadingAccountsViewState.SettingUpLink
        self.plaidLinkPresentor!.setupLink()
    }
    
    func startLoadingAccounts(){
        self.viewData.viewState = LoadingAccountsViewState.Loading
        self.setTimerToPull()
        self.aggregationService!.startAggregation()
    }
    
    func setTimerToPull(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 45.0) {
               //call any function
            self.timerPullResult()
        }
    }
    
    // This is the backup if the webhook is never recieved for whatever reason
    func timerPullResult(){
        print("timer done")
        if self.viewData.viewState == LoadingAccountsViewState.Loading{
            print("execute pull")
            self.aggregationService?.transactionPull()
        }
    }
    
    
    func handleAggregationResult(result: Result<String, Error>){
        switch result {
        case .failure(let _):
            self.viewData.viewState = LoadingAccountsViewState.Failure
        case .success(let result):
            self.itemId = result
            UserDefaults.standard.set(true, forKey: "UserOnboarded")
            self.viewData.viewState = LoadingAccountsViewState.Success
            self.itemManager.loadItems()
        }
    }
    
    
    
    func getLoadedAccounts() -> [AccountData]{
        
        if self.itemId != nil{
            do{
                return  try DataManager().getEntity(entityName: "AccountData") as! [AccountData]
            }
            catch{
                return [AccountData]()
            }
        }
        return [AccountData]()
    }
    

    
    func userPressedContinue(){
        
        print("plaid is connected")
        self.coordinator?.plaidIsConnected()
        
    }
    
    func userSelectedAddMoreAccounts(){
        self.launchPlaidLink()
    }
    
    
    
    func dismissPlaidLink(sender: PlaidLinkViewPresentor) {
        self.viewData.viewState = LoadingAccountsViewState.Initial
    }
    
    func plaidLinkSuccess(sender: PlaidLinkViewPresentor) {
        startLoadingAccounts()
        
    }
    
    func plaidIsConnected() {
        
    }
    
    func connectMoreAccounts() {
        
    }
    
    
}
