//
//  OnDemandRefreshViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/14/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import Foundation


class OnDemandRefreshViewModel {
    
    
    var viewData = LoadingAccountsViewData()
    var itemManager : ItemManagerService
    var aggregationServices = [PlaidDefaultUpdateService]()
    var completionCount = 0
    
    init(){
        self.viewData.viewState = LoadingAccountsViewState.Initial
        self.itemManager = ItemManagerService()
        generateServices()
    }
    
    func generateServices(){
        let items = self.itemManager.getItems()
        for item in items{
            let service = PlaidDefaultUpdateService.init(itemId: item.itemId!)
            service.completion = handleAggregationResult(result:)
            self.aggregationServices.append(service)
        }
        
    }
    
    func startLoadingAccounts(){
        self.viewData.viewState = LoadingAccountsViewState.Loading
        for service in self.aggregationServices{
            service.initiateDefaultUpdatePull()
        }
    }
    
    func handleAggregationResult(result: Result<String, Error>){
        switch result {
        case .failure(let _):
            
            self.completionCount = completionCount + 1
            if self.completionCount == self.aggregationServices.count{
                self.viewData.viewState = LoadingAccountsViewState.Success
            }
            
        case .success(let result):
            //self.itemId = result
            self.completionCount = completionCount + 1
            if self.completionCount == self.aggregationServices.count{
                self.viewData.viewState = LoadingAccountsViewState.Success
            }
        }
    }
    
}
