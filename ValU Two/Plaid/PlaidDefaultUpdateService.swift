//
//  PlaidInitialUpdateService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
 

class PlaidDefaultUpdateService{
    
    let plaidConnection = PlaidConnection()
    let itemId : String
    
    var completion : ((Result<String, Error>) -> ())?
    
    var backGroundCompletion : ((UIBackgroundFetchResult) -> ())?
    
    init(itemId: String, backGroundHandler: ((UIBackgroundFetchResult) -> ())? = nil){
        self.itemId = itemId
        self.backGroundCompletion = backGroundHandler
    }
    
    func initiateDefaultUpdatePull() {
        
        print("starting Default Update Pull")
        let today = Date()
        var mostRecentTransaction = Calendar.current.date(byAdding: .day, value: -30, to: today)
        
        do{
            mostRecentTransaction = try DataManager().fetchMostRecentTransactionDate()
        }
        catch{
            print("Could NOT get the most recent trasnsaction, falling back to 30 days")
            
        }

        
        do{
            try self.plaidConnection.getTransactions(itemId: self.itemId, startDate: mostRecentTransaction!, endDate: today, completion: self.defatulUpdatePullFinished(result:))
        }
        catch{
            print("could not start historical update pull")
            self.backGroundCompletion?(UIBackgroundFetchResult.noData)
        }
        
    }
    
    func historicalUpdatePull(){
        let today = Date()
        let mostRecentTransaction = Calendar.current.date(byAdding: .day, value: -60, to: today)
        
        do{
            try self.plaidConnection.getTransactions(itemId : self.itemId, startDate: mostRecentTransaction!, endDate: today, completion: self.defatulUpdatePullFinished(result:))
        }
        catch{
            print("could not start historical update pull")
            self.backGroundCompletion?(UIBackgroundFetchResult.noData)
        }
        
    }

    
    
    func defatulUpdatePullFinished(result: Result<Data, Error>){
    
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("UPDATE PULL FAILED")
                print(error)
                self.completion?(Result.failure(PlaidConnectionError.BadRequest))
                self.backGroundCompletion?(UIBackgroundFetchResult.noData)
            case .success(let dataResult):
                //Todo : Try-Catch this
                
                do{
                    try PlaidProccessor(spendingCategories: SpendingCategoryService().getSubSpendingCategories()).aggregate(response: dataResult, isInitial: false)
                    print("UPDATE PULL WOKED")
                    self.completion?(.success(self.itemId))
                    
                    self.backGroundCompletion?(UIBackgroundFetchResult.newData)
                    
                    NotificationCenter.default.post(name: .modelUpdate, object: nil)
                    
                }catch{
                    print("error occurred when proccessing default update transacions")
                    self.completion?(Result.failure(PlaidConnectionError.ProccessingError))
                    self.backGroundCompletion?(UIBackgroundFetchResult.noData)
                }
                
                //let budget = try? DataManager().getBudget()
                //budget?.objectWillChange.send()
                
                
            }
        }
        
        
    }
    
}
