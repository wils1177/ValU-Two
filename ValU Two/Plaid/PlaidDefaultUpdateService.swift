//
//  PlaidInitialUpdateService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class PlaidDefaultUpdateService{
    
    let plaidConnection = PlaidConnection()
    let itemId : String
    
    var completion : ((Result<String, Error>) -> ())?
    
    init(itemId: String){
        self.itemId = itemId
    }
    
    func initiateDefaultUpdatePull(){
        
        let today = Date()
        var mostRecentTransaction = Calendar.current.date(byAdding: .day, value: -30, to: today)
        
        do{
            mostRecentTransaction = try DataManager().fetchMostRecentTransactionDate()
        }
        catch{
            print("Could NOT get the most recent trasnsaction, falling back to 30 days")
        }

        try? self.plaidConnection.getTransactions(itemId: self.itemId, startDate: mostRecentTransaction!, endDate: today, completion: self.defatulUpdatePullFinished(result:))
        
    }
    
    func historicalUpdatePull(){
        let today = Date()
        let mostRecentTransaction = Calendar.current.date(byAdding: .day, value: -60, to: today)

        try? self.plaidConnection.getTransactions(itemId : self.itemId, startDate: mostRecentTransaction!, endDate: today, completion: self.defatulUpdatePullFinished(result:))
    }

    
    
    func defatulUpdatePullFinished(result: Result<Data, Error>){
    
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("UPDATE PULL FAILED")
                print(error)
                self.completion?(Result.failure(PlaidConnectionError.BadRequest))
            case .success(let dataResult):
                //Todo : Try-Catch this
                let budget = try? DataManager().getBudget()
                budget?.objectWillChange.send()
                do{
                    try PlaidProccessor(spendingCategories: SpendingCategoryService().getSubSpendingCategories()).aggregate(response: dataResult, isInitial: false)
                    print("UPDATE PULL WOKED")
                    self.completion?(.success(self.itemId))
                }catch{
                    print("error occurred when proccessing default update transacions")
                    self.completion?(Result.failure(PlaidConnectionError.ProccessingError))
                }
                
                
                
            }
        }
        
        
    }
    
}
