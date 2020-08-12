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
}

class LoadingAccountsViewData : ObservableObject{
    @Published var viewState = LoadingAccountsViewState.Loading
}

class LoadingAccountsPresentor : Presentor {
    
    var view : LoadingAccountsView?
    var coordinator : PlaidLinkDelegate?
    var aggregationService : PlaidInitialAggService?
    var viewData = LoadingAccountsViewData()
    var itemId : String?
    var itemManager : ItemManagerService
    
    init(itemManager: ItemManagerService){
        self.viewData.viewState = LoadingAccountsViewState.Initial
        self.itemManager = itemManager
    }

    
    func configure() -> UIViewController {
        let view = LoadingAccountsView(presentor: self, viewData: self.viewData)
        let vc = UIHostingController(rootView: view)
        self.aggregationService = PlaidInitialAggService(completion: self.handleAggregationResult(result:))
        
        
        
        return vc
    }
    

    
    func startLoadingAccounts(){
        self.viewData.viewState = LoadingAccountsViewState.Loading
        self.aggregationService!.startAggregation()
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
        self.coordinator?.connectMoreAccounts()
    }
    
    
}
