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
}

enum PlaidConnectionError: Error {
    case AccessTokenNotFound
    case PublicTokenNotFound
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
    
    var proccessor : PlaidProccessor
    var rootURL = "https://sandbox.plaid.com"
    var URLdict : [PlaidURLs : URL]
    
    typealias successHandler = (_ response : Data)  -> Any
        

    
    init(){
        self.proccessor = PlaidProccessor()
        self.URLdict = [PlaidURLs.GetCategories : URL(string : (rootURL + "/categories/get"))!]
        self.URLdict[PlaidURLs.TokenExchange] = URL(string : (rootURL + "/item/public_token/exchange"))!
        self.URLdict[PlaidURLs.GetTransactions] = URL(string : (rootURL + "/transactions/get"))!
        self.URLdict[PlaidURLs.GetAccounts] = URL(string : (rootURL + "/accounts/get"))!


    }
    
    func exchangePublicForAccessToken(dispatch: DispatchGroup) throws{
        
        print("how about this??")
        let URL = PlaidURLs.TokenExchange
        let keys = getAPIKeys()
        
        guard let publicKey: String = KeychainWrapper.standard.string(forKey: "public_token") else{
            print("Error: missing access Token")
            throw PlaidConnectionError.AccessTokenNotFound
        }
        
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "public_token" : publicKey]
        
        postRequest(url: URL, jsonBody: json, successHandler: self.proccessor.saveAccessToken(response:), dispatch: dispatch)
        
        
    }
    


    
    func getTransactions(dispatch: DispatchGroup) throws{
        
        let URL = PlaidURLs.GetTransactions
        let keys = getAPIKeys()
        
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "access_token") else{
            print("Error: missing access Token")
            throw PlaidConnectionError.AccessTokenNotFound
        }
        
        let calendar = Calendar.current
        let currentDate = Date()
        let startDate = calendar.date(byAdding: .month, value: -1, to: currentDate)
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = format.string(from: startDate!) as! String
        let formattedCurrentDate = format.string(from: currentDate) as! String
        
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "access_token" : accessToken, "start_date" : formattedStartDate, "end_date" : formattedCurrentDate]
        
        postRequest(url: URL, jsonBody: json, successHandler: proccessor.aggregate(response:), dispatch: dispatch)
    }
    
    
    
    
    func postRequest(url: PlaidURLs, jsonBody : [String: Any], successHandler : @escaping successHandler, dispatch: DispatchGroup? = nil){
        
        // not every PostRequest will require a distpatch group
        if dispatch != nil{
            dispatch?.enter()
        }
        
        
        let requestURL = URLdict[url]
        var request = URLRequest(url: requestURL!)
        let body = try? JSONSerialization.data(withJSONObject: jsonBody)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("error: \(error)")
            } else {
                
                let dataResponse = data
                
                //Response result
                DispatchQueue.main.async {
                    successHandler(dataResponse!)
                    
                    if dispatch != nil{
                        print("request done!")
                        dispatch?.leave()
                    }
                }
                
                    
                
  
            }
        }
        
        task.resume()
        
        
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
