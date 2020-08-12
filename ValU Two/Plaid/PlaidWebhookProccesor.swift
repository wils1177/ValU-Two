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
            //startIncomePull()
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
    
}

extension Notification.Name {
    static let initialUpdate = Notification.Name("initialUpdate")
    static let incomeReady = Notification.Name("incomeReady")
    static let modelUpdate = Notification.Name("modelUpdate")
}
