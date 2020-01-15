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
        else if webhookCode == "DEFAULT_UPDATE"{
            print("Proccessing Default Update Webhook")
        }
        
        
        
    }
    
    
    

}

extension Notification.Name {
    static let initialUpdate = Notification.Name("initialUpdate")
    static let incomeReady = Notification.Name("incomeReady")
}
