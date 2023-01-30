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
import Firebase
import FirebaseCrashlytics

enum PlaidUserDefaultKeys: String{
    case incomeReadyKey = "IncomeReadyFor:"
    case publicTokenKey = "public_token"
    case accessTokenKey = "AccessTokenFor:"
    case institutionId = "istitutionId-"
    case loginRequiredKey = "LoginRequiredFor:"
}

class PlaidProccessor{
    
    
    var spendingCategories : [SpendingCategory]
    var transactionRules = [TransactionRule]()
    
    init(spendingCategories: [SpendingCategory]){
        self.spendingCategories = spendingCategories
        
        do{
            self.transactionRules =  try DataManager().getTransactionRules()
        }catch{
            self.transactionRules = [TransactionRule]()
        }
    }
    
    
    // Save the access token securly to the device's KeyChain
    func saveAccessToken(response : Data) -> String{
        
        let decoder = JSONDecoder()
        do {
            let tokenResponse = try decoder.decode(TokenExchangeResponse.self, from: response)
            let accessTokenString = tokenResponse.accessToken
            print("PRINTING ACCESS TOKEN FOR TESTING PURPOSES")
            print(accessTokenString)
            let itemId = tokenResponse.itemId
            let saveSuccessful: Bool = KeychainWrapper.standard.set(accessTokenString, forKey: PlaidUserDefaultKeys.accessTokenKey.rawValue + itemId, withAccessibility: KeychainItemAccessibility.afterFirstUnlock)
            print(saveSuccessful)
            
            
            
            submitItemToServer(itemID: itemId)
            
            //Create a key for tracking whether we've recieved a webhook for the income product being ready
            let incomeItemKey = PlaidUserDefaultKeys.incomeReadyKey.rawValue + tokenResponse.itemId
            UserDefaults.standard.set(false, forKey: incomeItemKey)
            print("Retgurning ItemId:" + itemId)
            return itemId

            
        } catch (let err) {
            print(err.localizedDescription)
            return ""
        }
    

    }
    
    //Save the public token to the devices keychain
    static func savePublicToken(publicToken: String, institutionName: String, institutionId : String){
        
        let saveSuccessful: Bool = KeychainWrapper.standard.set(publicToken, forKey: PlaidUserDefaultKeys.publicTokenKey.rawValue)
        UserDefaults.standard.set(institutionName, forKey: PlaidUserDefaultKeys.institutionId.rawValue + institutionId)
        print(saveSuccessful)
    }
    
    // Get the public token from the public token generation response
    static func proccessPublicToken(response: Data) throws -> String{
        let decoder = JSONDecoder()
        do{
            let parsedResponse = try decoder.decode(PublicTokenResponse.self, from: response)
            return parsedResponse.publicToken
        }
        catch{
            print("Could not decode Plaid connction response for generating a public token")
            throw PlaidConnectionError.BadRequest
        }
    }
    
    
    /*
     Takes in Plaid JSON response
     Parses and saves trasnsactions response to CoreData
    */
    func aggregate(response: Data, isInitial: Bool = true) throws{
   
        let decoder = JSONDecoder()
        
        do {
            let parsedResponse = try decoder.decode(TransactionsResponse.self, from: response)
            
            proccessAccounts(response: parsedResponse.accounts, itemId: parsedResponse.item.itemId)

            //check to make sure there are some transactions before proccessing
            if parsedResponse.trasactions != nil{
                proccessTransactions(response: parsedResponse.trasactions!, itemId: parsedResponse.item.itemId)
            }
            
            if isInitial{
                processItem(response: parsedResponse.item)
            }
            
            BalanceHistoryService().snapShotBalanceHistory()
     
            
        } catch (let err) {
            print("error:")
            print(err)

            Crashlytics.crashlytics().record(error: err)
            throw PlaidConnectionError.ProccessingError
        }

        
    }
    
    
    func aggregateIncome(response: Data) {
        let decoder = JSONDecoder()
        
        do {
               let parsedResponse = try decoder.decode(IncomeResponse.self, from: response)
            self.proccessIncome(response: parsedResponse.income)
               print(parsedResponse)
        
               
           } catch (let err) {
               print("error aggregating income:")
               print(err)
           }
    }
    
    func proccessAccounts(response: [AccountJSON], itemId: String){
        
        
        let dataManager = DataManager()
        
        let existingAccounts = dataManager.getAccounts()
        
        for account in response{
            
            // Check if an account already exists, if so, update the balances.
            var accountAlreadyExists = false
            for existingAccount in existingAccounts{
                if existingAccount.accountId == account.accountId{
                    accountAlreadyExists = true
                    if account.balances.available != nil{
                        existingAccount.balances?.available = account.balances.available!
                    }
                    if account.balances.limit != nil {
                        existingAccount.balances?.limit = account.balances.limit!
                    }
                    existingAccount.balances?.current = account.balances.current
                    
                }
            }
            
            if !accountAlreadyExists{
                dataManager.saveAccount(account: account, itemId: itemId)
            }
            
            
        }
        
        dataManager.saveDatabase()
        
    }
    
    // Saves only transactions that are under an aggregated account
    func proccessTransactions(response: [TransactionJSON], itemId: String){
        
        let dataManager = DataManager()
        
        for transaction in response{
            print("printing transaction datetime: \(transaction.dateTime)")
            for account in dataManager.getAccounts(){
                if account.accountId == transaction.accountId{
                    
                    let transactionProcessor = TransactionProccessor(spendingCategories: self.spendingCategories, transactionRules: self.transactionRules)
                    
                    transactionProcessor.processTransaction(transaction: transaction, itemId: itemId)
                    
    
                }
            }

        }
        
        

        
    }
    
    
    
    func processItem(response : ItemJSON){
        print("Proccessing a New Item")
        let dataManager = DataManager()
        dataManager.saveItem(item: response)
        dataManager.saveDatabase()        
        
    }
    
    func proccessIncome(response: IncomeJSON){
        let dataManager = DataManager()
        dataManager.saveIncome(income: response)
        dataManager.saveDatabase()
    }
    
    
    func submitItemToServer(itemID: String){
        
        let token = Messaging.messaging().fcmToken!
        
        print("printing fcm token")
        print(token)
        //Configure the remote storeage with firebase
        let db = Firestore.firestore()
        db.collection("items").document(itemID).setData(["clientId" : token]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(itemID)")
            }
        }
        
    }



}
