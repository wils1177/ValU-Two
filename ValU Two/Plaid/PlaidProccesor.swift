//
//  PlaidProccesor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/12/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

class PlaidProccessor{
    
    init(){
        print("init to do")
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

}
