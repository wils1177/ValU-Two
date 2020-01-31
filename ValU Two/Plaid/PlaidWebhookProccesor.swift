//
//  PlaidWebhookProccesor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/8/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

class PlaidWebhookProccesor{
    
    func consumeWebhookMessage(webhookCode: String, itemId: String){
        
        print(webhookCode)
        
        if webhookCode == "INITIAL_UPDATE"{
            print("posting initial update notification")
            NotificationCenter.default.post(name: .initialUpdate, object: nil)
        }
        else if webhookCode == "PRODUCT_READY"{
            print("posting income ready notification")
            let incomeItemKey = PlaidUserDefaultKeys.incomeReadyKey.rawValue + itemId
            UserDefaults.standard.set(true, forKey: incomeItemKey)
            NotificationCenter.default.post(name: .incomeReady, object: nil)
        }
        else if webhookCode == "HISTORICAL_UPDATE"{
                print("Proccessing Histocial Update Webhook")
                DataManager().saveDatabase()
                historicalUpdatePull()
        }
        else if webhookCode == "DEFAULT_UPDATE"{
            print("Proccessing Default Update Webhook")
            DataManager().saveDatabase()
            initiateDefaultUpdatePull()
        }
        
        
        
    }
    
    func historicalUpdatePull(){
        let today = Date()
        var mostRecentTransaction = Calendar.current.date(byAdding: .day, value: -60, to: today)
        
        


        let plaidConnection = PlaidConnection()
        
        try? plaidConnection.getTransactions(startDate: mostRecentTransaction!, endDate: today, completion: self.defatulUpdatePullFinished(result:))
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


        let plaidConnection = PlaidConnection()
        
        try? plaidConnection.getTransactions(startDate: mostRecentTransaction!, endDate: today, completion: self.defatulUpdatePullFinished(result:))
        
    }

    
    
    func defatulUpdatePullFinished(result: Result<Data, Error>){
    
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
            case .success(let dataResult):
                //Todo : Try-Catch this 
                let budget = try? DataManager().getBudget()
                PlaidProccessor(budget: budget!).aggregate(response: dataResult, isInitial: false)
            }
        }
        
        
    }
    
    
    

}

extension Notification.Name {
    static let initialUpdate = Notification.Name("initialUpdate")
    static let incomeReady = Notification.Name("incomeReady")
    static let modelUpdate = Notification.Name("modelUpdate")
}
