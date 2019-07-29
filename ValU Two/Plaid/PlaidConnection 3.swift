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
    case TokenExchange
    case GetTransactions
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
    
    typealias successHandler = (_ response : [String : Any])  -> Void
        

    
    init(){
        self.proccessor = PlaidProccessor()
        self.URLdict = [PlaidURLs.GetAccounts : URL(string : (rootURL + "/categories/get"))!]
        self.URLdict[PlaidURLs.TokenExchange] = URL(string : (rootURL + "/item/public_token/exchange"))!
        self.URLdict[PlaidURLs.GetTransactions] = URL(string : (rootURL + "/transactions/get"))!


    }
    
    func aggregateAccounts(response: [String: Any]){
        self.proccessor.aggregateAccounts(response: response)
    }
    
    func exchangePublicForAccessToken(publicKey : String){
        
        let URL = PlaidURLs.TokenExchange
        let keys = getAPIKeys()
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "public_token" : publicKey]
        
        postRequest(url: URL, jsonBody: json, successHandler: self.proccessor.saveAccessToken(response:))
        
        
    }
    
    func getTransactions(){
        
        let URL = PlaidURLs.GetTransactions
        let keys = getAPIKeys()
        let accessToken: String! = KeychainWrapper.standard.string(forKey: "access_token")
        
        let calendar = Calendar.current
        let currentDate = Date()
        let startDate = calendar.date(byAdding: .month, value: -1, to: currentDate)
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = format.string(from: startDate!) as! String
        let formattedCurrentDate = format.string(from: currentDate) as! String
        
        let json: [String: Any] = ["client_id" : keys.clientID, "secret" : keys.clientSecret, "access_token" : accessToken!, "start_date" : formattedStartDate, "end_date" : formattedCurrentDate]
        
        postRequest(url: URL, jsonBody: json, successHandler: proccessor.aggregateTransactions(response:))
        
    }
    
    
    
    
    func postRequest(url: PlaidURLs, jsonBody : [String: Any], successHandler : @escaping successHandler){
        
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
                do{
                    
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        
                        dataResponse!, options: [])
                    
                    //Response result
                    successHandler(jsonResponse as! [String : Any])
                    
                } catch let parsingError {
                    print("Error", parsingError)
                    
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
