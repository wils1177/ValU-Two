//
//  FixNowService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/26/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

enum FixNowLoadingState{
    case start
    case loading
    case fail
}

class FixNowService: ObservableObject {
    
    var coordinator: BudgetsTabCoordinator
    
    @Published var exiredItemIds = [String]()
    
    var allItems = [ItemData]()
    
    @Published var state = FixNowLoadingState.start
    
    init(coordinator: BudgetsTabCoordinator){
        self.coordinator = coordinator
        self.exiredItemIds = getExpiredItemIds()
        
        do{
            self.allItems = try DataManager().getItems()
            self.exiredItemIds = self.getExpiredItemIds()
        }catch{
            self.allItems = [ItemData]()
        }
    }
    
    func showLinkUpdateMode(itemId: String){
        self.state = FixNowLoadingState.loading
        let tokenService = PublicTokenGenerationService(completion: self.handlePublicTokenResult(result:), itemId: itemId)
        tokenService.getPublicToken()
    }
    
    func getExpiredItemIds() -> [String]{
        var expiredItemIds = [String]()
        
        let items = self.allItems
        
        for item in items{
            if item.itemId != nil && checkIfItemIdIsExpired(itemId: item.itemId!){
                expiredItemIds.append(item.itemId!)
            }
        }
        
        return expiredItemIds
    }
    
    func checkIfItemIdIsExpired(itemId: String) -> Bool{
        let key = PlaidUserDefaultKeys.loginRequiredKey.rawValue + itemId
        let value = UserDefaults.standard.bool(forKey: key)
        if  value == true{
            return true
        }
        else{
            return false
        }

    }
    
    func handlePublicTokenResult(result: Result<PublicTokenGenrationServiceResult, Error>){
        switch result {
        case .failure(let error):
            //TODO handle error
            self.state = FixNowLoadingState.fail
            print(error)
        case .success(let result):
            print("Gathered Public Token")
            self.coordinator.showPlaidUpdate(publicToken: result.publicToken, itemId: result.itemId, sender: self)
            
            
        }
    }
    
    func markItemAsFixed(itemId: String){
        let key = PlaidUserDefaultKeys.loginRequiredKey.rawValue + itemId
        UserDefaults.standard.set(false, forKey: key)
        self.exiredItemIds = self.getExpiredItemIds()
    }
    
    func updateRecentlyFixedItem(itemId: String){
        let updateService = PlaidDefaultUpdateService(itemId: itemId)
        updateService.initiateDefaultUpdatePull()
        
    }
    
    
    
}
