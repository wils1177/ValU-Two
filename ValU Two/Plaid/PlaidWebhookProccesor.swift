//
//  PlaidWebhookProccesor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/8/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

class PlaidWebhookProccesor{
    
    var itemId : String?
    var backGroundCompletion : ((UIBackgroundFetchResult) -> ())?
    
    init(backGroundHandler: ((UIBackgroundFetchResult) -> ())? = nil){
        self.backGroundCompletion  = backGroundHandler
    }
    
    func consumeWebhookMessage(webhookCode: String, itemId: String) {
        
        print(webhookCode)
        self.itemId = itemId
        
        if webhookCode == "INITIAL_UPDATE"{
            print("posting initial update notification")
            NotificationCenter.default.post(name: .initialUpdate, object: nil)
            self.backGroundCompletion?(UIBackgroundFetchResult.newData)
        }
        else if webhookCode == "PRODUCT_READY"{
            print("posting income ready notification")
            let incomeItemKey = PlaidUserDefaultKeys.incomeReadyKey.rawValue + itemId
            UserDefaults.standard.set(true, forKey: incomeItemKey)
            self.backGroundCompletion?(UIBackgroundFetchResult.noData)
            //NotificationCenter.default.post(name: .incomeReady, object: nil, userInfo: userInfo)
            //startIncomePull()
        }
        else if webhookCode == "HISTORICAL_UPDATE"{
                print("Proccessing Histocial Update Webhook")
                DataManager().saveDatabase()
                PlaidDefaultUpdateService(itemId: self.itemId!, backGroundHandler: self.backGroundCompletion).historicalUpdatePull()
        }
        else if webhookCode == "DEFAULT_UPDATE"{
            print("Proccessing Default Update Webhook")
            BudgetCopyer().checkIfBudgetIsOutdated()
            DataManager().saveDatabase()
            PlaidDefaultUpdateService(itemId: self.itemId!, backGroundHandler: self.backGroundCompletion).initiateDefaultUpdatePull()
        }
        else if webhookCode == "ERROR"{
            handleErrorWebhook()
            self.backGroundCompletion?(UIBackgroundFetchResult.newData)
        }
        else{
            self.backGroundCompletion?(UIBackgroundFetchResult.noData)
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
