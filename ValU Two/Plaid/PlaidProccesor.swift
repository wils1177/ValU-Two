//
//  PlaidProccesor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/12/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import CoreData

class PlaidProccessor{
    
    
    // Save the access token securly to the device's KeyChain
    func saveAccessToken(response : Data){
        
        let decoder = JSONDecoder()
        do {
            let tokenResponse = try decoder.decode(TokenExchangeResponse.self, from: response)
            let accessTokenString = tokenResponse.accessToken
            let saveSuccessful: Bool = KeychainWrapper.standard.set(accessTokenString, forKey: "access_token")
            print(saveSuccessful)
            
        } catch (let err) {
            print(err.localizedDescription)
        }

    }
    
    //Save the public token to the devices keychain
    func savePublicToken(publicToken: String){
        
        let saveSuccessful: Bool = KeychainWrapper.standard.set(publicToken, forKey: "public_token")
        print(saveSuccessful)
    }
    
    
    /*
     Takes in Plaid JSON response
     Parses and saves trasnsactions response to CoreData
    */
    func aggregate(response: Data){
   
        let decoder = JSONDecoder()
        
        do {
            let parsedResponse = try decoder.decode(TransactionsResponse.self, from: response)
            
            proccessAccounts(response: parsedResponse.accounts)
            
            //check to make sure there are some transactions before proccessing
            if parsedResponse.trasactions != nil{
                proccessTransactions(response: parsedResponse.trasactions!)
            }
            
            processItem(response: parsedResponse.item)
     
            
        } catch (let err) {
            print("error:")
            print(err)
        }

        
    }
    
    func proccessAccounts(response: [AccountJSON]){
        
        
        let dataManager = DataManager()
        
        for account in response{
            
            if account.subType == "checking" || account.subType == "credit card"{
                
                dataManager.saveAccount(account: account)
                
            }
            
        }
        
        dataManager.saveDatabase()
        
    }
    
    // Saves only transactions that are under an aggregated account
    func proccessTransactions(response: [TransactionJSON]){
        
        let dataManager = DataManager()
        
        for transaction in response{
            
            for account in dataManager.getAccounts(){
                if account.accountId == transaction.accountId{
                    dataManager.saveTransaction(transaction: transaction)
                }
            }

        }
        
        dataManager.saveDatabase()

        
    }
    
    func processItem(response : ItemJSON){
        
        let dataManager = DataManager()
        dataManager.saveItem(item: response)

        dataManager.saveDatabase()
    }


}
