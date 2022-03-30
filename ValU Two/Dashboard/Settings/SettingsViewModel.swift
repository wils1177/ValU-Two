//
//  SettingsViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
//import LinkKit
import SwiftUI

struct ItemViewData: Hashable{
    var name : String
    var id : String
}

class ItemDeleteModel: ObservableObject {
    
    var itemIdToRemove : String?
    var showError  = false
    var item : ItemData
    var dataManager = DataManager()
    @Published var removing = false
    
    var parentModel: SettingsViewModel
    
    var name : String
    
    init(item: ItemData, parent: SettingsViewModel){
        self.item = item
        self.parentModel = parent
        self.name = UserDefaults.standard.value(forKey: PlaidUserDefaultKeys.institutionId.rawValue + item.institutionId!) as! String
    }
    
    func deleteItem(){
        
        self.removing = true
        self.itemIdToRemove = self.item.itemId!
        let itemId = self.item.itemId!
        
        //Remove Item from Plaid
        do{
            try PlaidConnection().removeItem(itemId: itemId, completion: self.itemRemoveFinished(result:))

        }
        catch{
            print("TODO: Handle this failure of item removal!")
        }
        
    }
    
    func itemRemoveFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
                self.showError = true
            case .success(let dataResult):
                self.removeLocalData()
                self.removing = false
                self.parentModel.updateView()
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
            dataManager.saveDatabase()
            
        }catch{
            print("Could not delete the item!")
        }
        
        
        
    }
    
}

class SettingsViewModel: ObservableObject, Presentor{
    
    var loadingAccountsPresentor : LoadingAccountsPresentor?
    var coordinator : SettingsFlowCoordinator?
    
    var dataManager = DataManager()
    @Published var items : [ItemData]?
    var viewData = [ItemViewData]()
    
    
    
    var rules = [TransactionRule]()
    
    
    init(){
        //print("settings view model init")

       updateView()
       getTransactionRules()
    }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: SettingsView(viewModel: self))
        return vc
    }
    
    
    
    deinit {
        //print("Settings view model DEINIT")
    }
    
    func getTransactionRules(){
        
        do{
            let rules = try DataManager().getTransactionRules()
            self.rules = rules
        }
        catch{
            self.rules = [TransactionRule]()
        }
        
        
    }
    
    func updateView(){
        
        self.viewData = [ItemViewData]()
        self.items = [ItemData]()
        
        do{
            self.items = try dataManager.getItems()
            
            //DELETE ME
            for item in self.items!{
                print("printing itemID: \(item.itemId)")
            }
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
    
    
    
    
    
    func dismiss(){
        self.coordinator?.dismissSettings()
    }
    
    
    
    
    
    
    
    

    
}
