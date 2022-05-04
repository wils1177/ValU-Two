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
                processRefreshResults(result: refreshResult)
            }
            catch{
                print("COULD NOT REFRESH")
            }
            
            
        }
    }
    
    func processRefreshResults(result: Result<Data, Error>){
    
        
        DispatchQueue.main.async {
            
            switch result {
            case .failure(let error):
                print("UPDATE PULL FAILED")
                print(error)
            case .success(let dataResult):
                
                do{
                    try PlaidProccessor(spendingCategories: SpendingCategoryService().getSubSpendingCategories()).aggregate(response: dataResult, isInitial: false)
                    print("UPDATE PULL WOKED")
                    NotificationCenter.default.post(name: .modelUpdate, object: nil)
                    
                }
                catch{
                    
                    print("error occurred when proccessing default update transacions")
                    print(error)
                }
                
            }
            
        }
        
    }
    
     
    
    
    
}
