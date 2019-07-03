//
//  PlaidConnection.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/12/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

enum PlaidURLs{
    case GetAccounts
}

class PlaidConnection{
    
    let publicKey : String
    var proccessor : PlaidProccessor
    var rootURL = "https://sandbox.plaid.com"
    var URLdict : [PlaidURLs : URL]
        

    
    init(publicKey: String){
        self.publicKey = publicKey
        self.proccessor = PlaidProccessor()
        self.URLdict = [PlaidURLs.GetAccounts : URL(string : (rootURL + "/categories/get"))!]
    }
    
    func aggregateAccounts(response: [String: Any]){
        self.proccessor.aggregateAccounts(response: response)
    }
    
    //POST /categories/get
    func getTransactionCategories(){
        
        let URL = URLdict[PlaidURLs.GetAccounts]
        var request = URLRequest(url: URL!)
        
        let body = try? JSONSerialization.data(withJSONObject: [])
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
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
