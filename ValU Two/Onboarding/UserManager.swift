//
//  UserManager.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/22/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import Foundation
import CloudKit
import SwiftKeychainWrapper

enum UserStorageKeys: String{
    case userIdKey = "cloudUserId"
    
}

class UserManager{
   
    
    func onboardUser(userId: String){
        
        //Check if this is an existing cloudKit User
         
    }
    
    func checkiCloudStatus() async {
        try! await print(CKContainer.default().accountStatus())
    }
    
    func saveUserIdToKeyChain(userId: String){
        let saveSuccessful: Bool = KeychainWrapper.standard.set(userId, forKey: UserStorageKeys.userIdKey.rawValue, withAccessibility: KeychainItemAccessibility.afterFirstUnlock)
        print(saveSuccessful)
    }
    
    func checkIfUserExists(userId: String) -> Bool{
        
        return false
        
    }
    
}
