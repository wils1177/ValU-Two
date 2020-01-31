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

enum PlaidUserDefaultKeys: String{
    case incomeReadyKey = "IncomeReadyFor:"
}

class PlaidProccessor{
    
    var spendingCategories : [SpendingCategory]
    var budget : Budget
    var transactionRules = [TransactionRule]()
    
    init(budget: Budget){
        self.budget = budget
        self.spendingCategories = budget.getSubSpendingCategories()
        
        do{
            self.transactionRules =  try DataManager().getTransactionRules()
        }catch{
            self.transactionRules = [TransactionRule]()
        }
    }
    
    
    // Save the access token securly to the device's KeyChain
    func saveAccessToken(response : Data){
        
        let decoder = JSONDecoder()
        do {
            let tokenResponse = try decoder.decode(TokenExchangeResponse.self, from: response)
            let accessTokenString = tokenResponse.accessToken
            let saveSuccessful: Bool = KeychainWrapper.standard.set(accessTokenString, forKey: "access_token")
            print(saveSuccessful)
            
            submitItemToServer(itemID: tokenResponse.itemId)
            
            //Create a key for tracking whether we've recieved a webhook for the income product being ready
            let incomeItemKey = PlaidUserDefaultKeys.incomeReadyKey.rawValue + tokenResponse.itemId
            UserDefaults.standard.set(false, forKey: incomeItemKey)

            
        } catch (let err) {
            print(err.localizedDescription)
        }

    }
    
    //Save the public token to the devices keychain
    static func savePublicToken(publicToken: String){
        
        let saveSuccessful: Bool = KeychainWrapper.standard.set(publicToken, forKey: "public_token")
        print(saveSuccessful)
    }
    
    
    /*
     Takes in Plaid JSON response
     Parses and saves trasnsactions response to CoreData
    */
    func aggregate(response: Data, isInitial: Bool = true){
   
        let decoder = JSONDecoder()
        
        do {
            let parsedResponse = try decoder.decode(TransactionsResponse.self, from: response)
            
            if isInitial{
                proccessAccounts(response: parsedResponse.accounts)
            }
            
            
            //check to make sure there are some transactions before proccessing
            if parsedResponse.trasactions != nil{
                proccessTransactions(response: parsedResponse.trasactions!)
            }
            
            if isInitial{
                processItem(response: parsedResponse.item)
            }
            
     
            
        } catch (let err) {
            print("error:")
            print(err)
        }

        
    }
    
    
    func aggregateIncome(response: Data){
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
                    
                    let newTransaction = dataManager.saveTransaction(transaction: transaction)
                        
                    TransactionProccessor(budget: self.budget, transactionRules: self.transactionRules).proccessTransactionToCategory(transaction: newTransaction, spendingCategories: self.spendingCategories)

                    
                    
                }
            }

        }
        
        

        
    }
    
    
    
    func processItem(response : ItemJSON){
        
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
