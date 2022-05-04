//
//  PlaidConnection.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/12/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper


enum PlaidURLs{
    case GetAccounts
    case GetCategories
    case TokenExchange
    case GetTransactions
    case GetIncome
    case RemoveItem
    case GetPublicToken
    case GetLinkToken
}

enum PlaidConnectionError: Error {
    case AccessTokenNotFound
    case PublicTokenNotFound
    case BadRequest
    case ProccessingError
}

struct Keys : Codable{
    let clientID : String
    let clientSecret : String
    
    enum CodingKeys : String, CodingKey {
        case clientID =  "CLIENT_ID"
        case clientSecret =  "SANDBOX_CLIENT_SECRET"
    }
}

class PlaidConnection{
    
    var rootURL = "https://sandbox.plaid.com"
    let webhookURL = "https://us-central1-valu-2.cloudfunctions.net/plaidWebhook"
    var URLdict : [PlaidURLs : URL]
    var clientName = "ValU-Two"
    
    typealias successHandler = (_ response : Data)  -> Any
        

    
    init(){
        self.URLdict = [PlaidURLs.GetCategories : URL(string : (rootURL + "/categories/get"))!]
        self.URLdict[PlaidURLs.TokenExchange] = URL(string : (rootURL + "/item/public_token/exchange"))!
        self.URLdict[PlaidURLs.GetTransactions] = URL(string : (rootURL + "/transactions/get"))!
        self.URLdict[PlaidURLs.GetAccounts] = URL(string : (rootURL + "/accounts/get"))!
        self.URLdict[PlaidURLs.GetIncome] = URL(string : (rootURL + "/income/get"))!
        self.URLdict[PlaidURLs.RemoveItem] = URL(string : (rootURL + "/item/remove"))!
        self.URLdict[PlaidURLs.GetPublicToken] = URL(string : (rootURL + "/item/public_token/create"))!
        self.URLdict[PlaidURLs.GetLinkToken] = URL(string : (rootURL + "/link/token/create"))
        

    }
    
    func exchangePublicForAccessToken(completion : @escaping (Result<Data, Error>) -> ()) throws{
        
        let URL = PlaidURLs.TokenExchange
        let keys = getAPIKeys()
        
        guard let publicKey: String = KeychainWrapper.standard.string(forKey: PlaidUserDefaultKeys.publicTokenKey.rawValue) else{
            print("Error: missing access Token")
            throw PlaidConnectionError.AccessTokenNotFound
        }
        
        
        
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "public_token" : publicKey]
        
        try postRequest(url: URL, jsonBody: json, completion: completion)
        
        
    }
    
    // TODO
    func getLinkToken(completion : @escaping (Result<Data, Error>) -> ()) throws{
        
        let URL = PlaidURLs.GetLinkToken
        let keys = getAPIKeys()
        
        let userId = UserDefaults.standard.string(forKey: "userID") ?? "no user id"
        let user: [String : Any] = ["client_user_id" : userId]
        
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "client_name" : self.clientName, "language" : "en", "country_codes" : ["US"], "user" : user, "products" : ["transactions"], "webhook" : self.webhookURL]
        
        
        try postRequest(url: URL, jsonBody: json, completion: completion)
        
        
    }
    

    func createTransactionsJSON(itemId: String, startDate: Date, endDate: Date) throws -> [String: Any] {
        
        
        let keys = getAPIKeys()
        
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: PlaidUserDefaultKeys.accessTokenKey.rawValue + itemId) else{
            print("Error: missing access Token")
            throw PlaidConnectionError.AccessTokenNotFound
        }
        
 
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = format.string(from: startDate)
        let formattedEndDate = format.string(from: endDate)
        
        print(startDate)
        print(endDate)
        
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "access_token" : accessToken, "start_date" : formattedStartDate, "end_date" : formattedEndDate]
        
        return json
        
    }
    
    func getTransactions(itemId: String, startDate: Date, endDate: Date, completion : @escaping (Result<Data, Error>) -> ()) throws{
        
        let URL = PlaidURLs.GetTransactions
        let json = try createTransactionsJSON(itemId: itemId, startDate: startDate, endDate: endDate)
        
            
        try postRequest(url: URL, jsonBody: json, completion: completion, dispatch: nil)
        
         
    }
    
    func getPublicToken(itemId: String, completion : @escaping (Result<Data, Error>) -> ()) throws{
        
        let URL = PlaidURLs.GetPublicToken
        let keys = getAPIKeys()
        
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: PlaidUserDefaultKeys.accessTokenKey.rawValue + itemId) else{
            print("Error: missing access Token")
            throw PlaidConnectionError.AccessTokenNotFound
        }
        
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "access_token" : accessToken]
        try postRequest(url: URL, jsonBody: json, completion: completion, dispatch: nil)
    }
    
    func getIncome(itemId: String, completion : @escaping (Result<Data, Error>) -> ()) throws{
        
        let URL = PlaidURLs.GetIncome
        let keys = getAPIKeys()
        
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: PlaidUserDefaultKeys.accessTokenKey.rawValue + itemId) else{
            print("Error: missing access Token")
            throw PlaidConnectionError.AccessTokenNotFound
        }
        
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "access_token" : accessToken]
        
        try postRequest(url: URL, jsonBody: json, completion: completion, dispatch: nil)
        
    }
    
    func removeItem(itemId: String, completion : @escaping (Result<Data, Error>) -> ()) throws{
        
        let URL = PlaidURLs.RemoveItem
        let keys = getAPIKeys()
        
        
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: PlaidUserDefaultKeys.accessTokenKey.rawValue + itemId) else{
            print("Error: missing access Token")
            throw PlaidConnectionError.AccessTokenNotFound
        }
        
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "access_token" : accessToken]
        
        try postRequest(url: URL, jsonBody: json, completion: completion, dispatch: nil)
        
    }
    
    
    
    
    func postRequest(url: PlaidURLs, jsonBody : [String: Any], completion : @escaping (Result<Data, Error>) -> (), dispatch: DispatchGroup? = nil) throws{
        
        
        let requestURL = URLdict[url]
        var request = URLRequest(url: requestURL!)
        let body = try? JSONSerialization.data(withJSONObject: jsonBody)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("error: \(error)")
                    
                completion(Result.failure(PlaidConnectionError.BadRequest))
                
            } else {
                
                let dataResponse = data
                //Check if it was a 200 response code or not
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200{
                        let myJSON = String(data: dataResponse!, encoding: String.Encoding.utf8)
                        print(myJSON)
                        completion(Result.failure(PlaidConnectionError.BadRequest))

                        
                        
                    }else{
                        print("Post Request Complete")
                        completion(.success(dataResponse!))

                    
                }
            }
                else{
                    completion(Result.failure(PlaidConnectionError.BadRequest))
                    
                }
                
                
                if dispatch != nil{
                    print("request done!")
                    dispatch?.leave()
                }
                
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                   //print(jsonObject) // This will print the below json.
                }
                catch{}
                
                //Response result
                

            }
        }
        
        task.resume()
        
        
    }
    
    //MARK: Here are the async await version of these requests
    
    func getTransactionsWithAwait(itemId: String, startDate: Date, endDate: Date) async throws -> (Result<Data, Error>){
        
        let URL = PlaidURLs.GetTransactions
        let json = try createTransactionsJSON(itemId: itemId, startDate: startDate, endDate: endDate)
        
        return await postRequestWithAwait(url: URL, jsonBody: json)
        
    }
    
    func postRequestWithAwait(url: PlaidURLs, jsonBody : [String: Any]) async -> (Result<Data, Error>) {
        
        let requestURL = URLdict[url]
        var request = URLRequest(url: requestURL!)
        let body = try? JSONSerialization.data(withJSONObject: jsonBody)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            
            
           return .success(data)
            
        }
        catch{
            print(error)
            return .failure(PlaidConnectionError.BadRequest)
            
        }
        
    }
    
    func getAPIKeys() -> Keys{
        
        var keys : Keys?
        let url = Bundle.main.url(forResource: "APIKeys", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        do {
            keys = try decoder.decode(Keys.self, from: data)
        } catch (let err) {
            print(err.localizedDescription)
        }
        
        return keys!
        
    }
    
    //POST /categories/get
    func getTransactionCategories(){
        
        let URL = URLdict[PlaidURLs.GetAccounts]
        var request = URLRequest(url: URL!)
        
        let json: [String: Any] = [:]
        let body = try? JSONSerialization.data(withJSONObject: json)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("error: \(error)")
            } else {
                let dataResponse = data
                do{
                    
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        
                        dataResponse!, options: [])
                    
                    print(jsonResponse) //Response result
                    
                } catch let parsingError {
                    print("Error", parsingError)
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
    
    
    
}
