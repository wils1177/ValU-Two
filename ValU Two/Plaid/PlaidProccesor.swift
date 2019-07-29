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
    
    var accounts : [Account]
    
    init(accounts: [Account]){
        self.accounts = accounts
    }
    
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
    
    
    func aggregateAccounts(response: Data){
        let decoder = JSONDecoder()
        
        do {
            let paresedResponse = try decoder.decode(AccountsResponse.self, from: response)
            let item = paresedResponse.item
            let accountData = paresedResponse.accounts
            
            for account in accountData{
                if account.subType == "checking" || account.subType == "credit card"{
                    let newAccount = Account(accountData: account, item: item)
                    self.accounts.append(newAccount)
                }
                
            }
            print(self.accounts)
            
        } catch (let err) {
            print("error:")
            print(err)
        }
    }
    
    func aggregateTransactions(response: Data){
   
        let decoder = JSONDecoder()
        
        do {
            let transactionsResponse = try decoder.decode(TransactionsResponse.self, from: response)
            addTransactions(transactionsResponse: transactionsResponse)
        } catch (let err) {
            print("error:")
            print(err)
        }
        
    }
    
    
    func addTransactions(transactionsResponse : TransactionsResponse){
        
        for account in self.accounts{
            
            for transaction in transactionsResponse.trasactions{
                if transaction.accountId == account.accountData.accountId{
                    account.transactions.append(transaction)
                }
            }
            
            
            
        }
        

        
    }

}
