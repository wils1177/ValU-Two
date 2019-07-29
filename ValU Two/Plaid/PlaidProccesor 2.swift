//
//  PlaidProccesor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/12/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class PlaidProccessor{
    
    init(){
        print("init to do")
    }
    
    func saveAccessToken(response : [String: Any]){
        
        let accessToken = response["access_token"]! as! String
        //let itemID = response["item_id"]
        
        let saveSuccessful: Bool = KeychainWrapper.standard.set(accessToken, forKey: "access_token")
        print(saveSuccessful)
    }
    
    func aggregateAccounts(response: [String: Any]){
        
        let accounts = response["accounts"] as! [[String: Any]]
        
        let institution = response["institution"] as! [String: Any]
        let institutionName = institution["name"]
        let institutionId = institution["institution_id"]
        print(institutionName!)
        
        for account in accounts{
            
            let accountId = account["id"]
            let accountName = account["name"]
            let accountType = account["type"]
            let accountSubType = account["subtype"]
            
            print(accountName!)
            
        }
        
    }
    
    func aggregateTransactions(response: [String: Any]){
        print(response)
    }

}
