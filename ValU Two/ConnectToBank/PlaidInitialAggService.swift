//
//  PlaidInitialAggService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/8/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import FirebaseCrashlytics

class PlaidInitialAggService {
    
    var completion : (Result<String, Error>) -> ()
    var plaidProccesor : PlaidProccessor
    var itemId : String?
    var spendingCategories = SpendingCategoryService().getSubSpendingCategories()
    
    init(completion : @escaping (Result<String, Error>) -> ()){
        self.completion = completion
        self.plaidProccesor = PlaidProccessor(spendingCategories: self.spendingCategories)
        NotificationCenter.default.addObserver(self, selector: #selector(startTransactionsPull(_:)), name: .initialUpdate, object: nil)
    }
    
    deinit{
        //print("Dellocate the LoadingAccounts Presentor")
        NotificationCenter.default.removeObserver(self, name: .initialUpdate, object: nil)
    }
    
    // Start Aggregation proccess
    func startAggregation(){
        
        let plaid = PlaidConnection()
        
        do{
            print("Exchanging public token...")
            try plaid.exchangePublicForAccessToken(completion: self.tokenExchangeFinished(result:))
        }
        catch{
            //TODO: Enter Error State
            self.completion(Result.failure(PlaidConnectionError.BadRequest))
        }

    }
    
    func tokenExchangeFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self.completion(Result.failure(PlaidConnectionError.BadRequest))
                print(error)
            case .success(let dataResult):
                self.itemId = self.plaidProccesor.saveAccessToken(response: dataResult)
                print("itemId officially set")
            }
        }
        
    }
    
    @objc func startTransactionsPull(_ notification:Notification){
        print("starting transaction pull:")
        print(self)
        self.transactionPull()
        
    }
    
    func transactionPull(){
        let calendar = Calendar.current
        let currentDate = Date()
        let startDate = calendar.date(byAdding: .month, value: -1, to: currentDate)
        let endDate = currentDate
        let plaid = PlaidConnection()
              
        do{
            try plaid.getTransactions(itemId: self.itemId!, startDate: startDate!, endDate: endDate, completion: self.transactionsPullFinished(result:))
        }
        catch{
            //TODO: Enter Error State
            self.completion(Result.failure(PlaidConnectionError.BadRequest))
        }
        
    }
    
    func transactionsPullFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self.completion(Result.failure(PlaidConnectionError.BadRequest))
                print(error)
                Crashlytics.crashlytics().record(error: error)
            case .success(let dataResult):
                do{
                    try self.plaidProccesor.aggregate(response: dataResult)
                    TransactionProccessor(spendingCategories: self.spendingCategories).updateInitialThiryDaysSpent()
                    self.completion(.success(self.itemId!))
                }
                catch{
                    self.completion(Result.failure(PlaidConnectionError.BadRequest))
                }
                
                
                

            }
        }
        
    }
    
    
    
}
