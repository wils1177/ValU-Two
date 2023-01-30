//
//  OnDemandRefreshViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/14/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import Foundation


class OnDemandRefreshViewModel {
    
    
    var itemManager : ItemManagerService
    
    var somethingToDoWhenRefrehIsDone : (() -> ())?
    
    init(){
        self.itemManager = ItemManagerService()
    }
    
    
    
    func refreshAllItems() async{
        let items = self.itemManager.getItems()
        for item in items{
            
            let plaidConnection = PlaidConnection()
            
            let today = Date()
            var mostRecentTransaction = Calendar.current.date(byAdding: .day, value: -30, to: today)
            do{
                mostRecentTransaction = try DataManager().fetchMostRecentTransactionDate()
            }
            catch{
                print("Could NOT get the most recent trasnsaction, falling back to 30 days")
                
            }
            
            do {
                let refreshResult = try await plaidConnection.getTransactionsWithAwait(itemId: item.itemId!, startDate: mostRecentTransaction!, endDate: today)
                processRefreshResults(result: refreshResult, itemId: item.itemId!)
            }
            catch{
                print("COULD NOT REFRESH")
            }
            
            
        }
    }
    
    func processRefreshResults(result: Result<Data, Error>, itemId: String){
    
        
        DispatchQueue.main.async {
            
            switch result {
            case .failure(let error):
                print("UPDATE PULL FAILED")
                print(error)
                
                
                
                
            case .success(let dataResult):
                
                do{
                    
                    //Check if we have an item error First
                    if self.checkForItemError(data: dataResult){
                        print("ITEM ERROR ON REFRESH")
                        
                        let loginRequiredKey = PlaidUserDefaultKeys.loginRequiredKey.rawValue + itemId
                        UserDefaults.standard.set(true, forKey: loginRequiredKey)
                        NotificationCenter.default.post(name: .modelUpdate, object: nil)
                    }
                    else{
                        try PlaidProccessor(spendingCategories: SpendingCategoryService().getSubSpendingCategories()).aggregate(response: dataResult, isInitial: false)
                        print("UPDATE PULL WOKED")
                        NotificationCenter.default.post(name: .modelUpdate, object: nil)
                    }
                    
                    
                    
                }
                catch{
                    
                    print("error occurred when proccessing default update transacions")
                    print(error)
                }
                
            }
            
        }
        
    }
    
    func checkForItemError(data: Data) -> Bool{
        let decoder = JSONDecoder()
        do{
            
            let parsedResponse = try decoder.decode(ErrorResponse.self, from: data)
            
            if parsedResponse.errorCode == "ITEM_LOGIN_REQUIRED"{
                return true
            }
            else{
                return false
            }
            
            
        }
        catch{
            return false
        }
    }
    
     
    
    
    
}
