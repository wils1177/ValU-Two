//
//  ConnectToBankViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/1/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class ItemManagerService: ObservableObject{
    
    var items = [ItemData]()
    var itemIdToRemove : String?
    @Published var showError = false
    
    init(){
        self.loadItems()
    }
    
    func loadItems(){
        do{
            self.items = try DataManager().getItems()
        }
        catch{
            print("COULD NOT LOAD ITEMS")
            self.items = [ItemData]()
        }

    }
    
    func getItems() -> [ItemData]{
        return self.items
    }
    
    func getNameOfItem(item: ItemData) -> String{
        let name = UserDefaults.standard.value(forKey: PlaidUserDefaultKeys.institutionId.rawValue + item.institutionId!) as! String
        return name
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
        let dataManager = DataManager()
        
        do{
            try dataManager.deleteEntity(predicate: PredicateBuilder().generateItemPredicate(itemId: itemId), entityName: "ItemData")
            try dataManager.deleteEntity(predicate: PredicateBuilder().generateItemPredicate(itemId: itemId), entityName: "AccountData")
            try dataManager.deleteEntity(predicate: PredicateBuilder().generateItemPredicate(itemId: itemId), entityName: "Transaction")
            try dataManager.deleteEntity(predicate: PredicateBuilder().generateItemPredicate(itemId: itemId), entityName: "CategoryMatch")
            
            dataManager.saveDatabase()
            //self.budget!.updateAmountSpent()
            dataManager.saveDatabase()
            
            loadItems()
            
            self.objectWillChange.send()
            
            NotificationCenter.default.post(name: .modelUpdate, object: nil)
            
        }catch{
            print("Could not delete the item!")
        }
        
        
        
    }
    
    
    
    
}
