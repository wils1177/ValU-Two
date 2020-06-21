//
//  SettingsViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import LinkKit
import SwiftUI

struct ItemViewData: Hashable{
    var name : String
    var id : String
}

class SettingsViewModel: ObservableObject, Presentor{
    
    var loadingAccountsPresentor : LoadingAccountsPresentor?
    var budget : Budget?
    var coordinator : SettingsFlowCoordinator?
    
    var dataManager = DataManager()
    @Published var items : [ItemData]?
    var viewData = [ItemViewData]()
    var itemIdToRemove : String?
    var showError  = false
    
    init(budget: Budget){
        //print("settings view model init")
        self.budget = budget
       updateView()
        
    }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: SettingsView(viewModel: self))
        return vc
    }
    
    
    
    deinit {
        //print("Settings view model DEINIT")
    }
    
    func updateView(){
        
        self.viewData = [ItemViewData]()
        self.items = [ItemData]()
        
        do{
            self.items = try dataManager.getItems()
        }
        catch{
            self.items = [ItemData]()
        }
        
        
        
        generateViewData()
        
    }
    
    func generateViewData(){
        
        for item in self.items!{
            
            let name = UserDefaults.standard.value(forKey: PlaidUserDefaultKeys.institutionId.rawValue + item.institutionId!) as! String
            
            self.viewData.append(ItemViewData(name:name, id: item.itemId!))
            
        }
        
    }
    
    func connectAccounts(){
        self.coordinator?.connectAccounts()
    }
    
    func deleteItem(itemId: String){
        
        self.itemIdToRemove = itemId
        
        //Remove Item from Plaid
        do{
            try PlaidConnection().removeItem(itemId: itemId, completion: self.itemRemoveFinished(result:))
        }
        catch{
            print("TODO: Handle this failure of item removal!")
        }
        
        
        
        
        
    }
    
    func dismiss(){
        self.coordinator?.dismissSettings()
    }
    
    
    func itemRemoveFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
                self.showError = true
            case .success(let dataResult):
                self.removeLocalData()
                

            }
        }
        
    }
    
    func removeLocalData(){
        
        
        let itemId = self.itemIdToRemove!
        
        do{
            try dataManager.deleteEntity(predicate: PredicateBuilder().generateItemPredicate(itemId: itemId), entityName: "ItemData")
            try dataManager.deleteEntity(predicate: PredicateBuilder().generateItemPredicate(itemId: itemId), entityName: "AccountData")
            try dataManager.deleteEntity(predicate: PredicateBuilder().generateItemPredicate(itemId: itemId), entityName: "Transaction")
            try dataManager.deleteEntity(predicate: PredicateBuilder().generateItemPredicate(itemId: itemId), entityName: "CategoryMatch")
            
            dataManager.saveDatabase()
            self.budget!.updateAmountSpent()
            dataManager.saveDatabase()
            updateView()
            NotificationCenter.default.post(name: .modelUpdate, object: nil)
            
        }catch{
            print("Could not delete the item!")
        }
        
        
        
    }
    

    
}
