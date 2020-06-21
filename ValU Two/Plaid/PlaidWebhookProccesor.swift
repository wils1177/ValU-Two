//
//  PlaidWebhookProccesor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/8/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

class PlaidWebhookProccesor{
    
    var itemId : String?
    
    func consumeWebhookMessage(webhookCode: String, itemId: String){
        
        print(webhookCode)
        self.itemId = itemId
        
        if webhookCode == "INITIAL_UPDATE"{
            print("posting initial update notification")
            NotificationCenter.default.post(name: .initialUpdate, object: nil)
        }
        else if webhookCode == "PRODUCT_READY"{
            print("posting income ready notification")
            let incomeItemKey = PlaidUserDefaultKeys.incomeReadyKey.rawValue + itemId
            UserDefaults.standard.set(true, forKey: incomeItemKey)
            //NotificationCenter.default.post(name: .incomeReady, object: nil, userInfo: userInfo)
            startIncomePull()
        }
        else if webhookCode == "HISTORICAL_UPDATE"{
                print("Proccessing Histocial Update Webhook")
                DataManager().saveDatabase()
                PlaidDefaultUpdateService(itemId: self.itemId!).historicalUpdatePull()
        }
        else if webhookCode == "DEFAULT_UPDATE"{
            print("Proccessing Default Update Webhook")
            BudgetCopyer().checkIfBudgetIsOutdated()
            DataManager().saveDatabase()
            PlaidDefaultUpdateService(itemId: self.itemId!).initiateDefaultUpdatePull()
        }
        else if webhookCode == "ERROR"{
            handleErrorWebhook()
        }
        
        
        
    }
    
    
    func handleErrorWebhook(){
        
        let loginRequiredKey = PlaidUserDefaultKeys.loginRequiredKey.rawValue + self.itemId!
        UserDefaults.standard.set(true, forKey: loginRequiredKey)
        
    }
    
    
    
    
    
    
    
    func startIncomePull(){
        print("getting income...")
        //TODO: Handle each of these errors!
        try? DataManager().deleteIncomeData()
        try? PlaidConnection().getIncome(itemId: self.itemId!, completion: self.incomePullFinished(result:))
    }
    
    
    func incomePullFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .success(let dataResult):
                    print("income success")
                    
                    let budget = try? DataManager().getBudget()
                    //TODO: This should be a try/catch
                    PlaidProccessor(budget: budget!).aggregateIncome(response: dataResult)
            case .failure(let error):
                    print(error)
            }
        }
        
    }
    
    
    

}

extension Notification.Name {
    static let initialUpdate = Notification.Name("initialUpdate")
    static let incomeReady = Notification.Name("incomeReady")
    static let modelUpdate = Notification.Name("modelUpdate")
}
